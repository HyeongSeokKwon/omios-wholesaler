import 'package:deepy_wholesaler/repository/http_repository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';

part 'infinity_scroll_event.dart';
part 'infinity_scroll_state.dart';

class InfinityScrollBloc
    extends Bloc<InfinityScrollEvent, InfinityScrollState> {
  final HttpRepository _httpRepository = HttpRepository();

  InfinityScrollBloc() : super(InfinityScrollState.initial()) {
    on<AddDataEvent>(addData);
    on<ResetDataEvent>(resetData);
  }

  Future<void> addData(
      AddDataEvent event, Emitter<InfinityScrollState> emit) async {
    Map<String, dynamic> response;
    if (state.getData['next'] != null) {
      Uri nextLink = Uri.parse(state.getData['next']);
      emit(state.copyWith(getState: FetchState.loading));
      response = await _httpRepository.httpGet(
          nextLink.path, nextLink.queryParameters);
      emit(state.copyWith(
          getState: FetchState.success,
          productData: List.of(state.productData)
            ..addAll(response['data']['results']),
          getData: response['data']));
    }
  }

  Future<void> resetData(
      ResetDataEvent event, Emitter<InfinityScrollState> emit) async {
    emit(state.copyWith(
        getState: FetchState.success,
        getData: event.getData,
        productData: event.getData['results']));
  }
}
