import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/repository/edit_repository.dart';
import 'package:equatable/equatable.dart';

part 'inititem_event.dart';
part 'inititem_state.dart';

class InitEditItemBloc extends Bloc<InitEditItemEvent, InitEditItemState> {
  EditRepository editRepository = EditRepository();

  InitEditItemBloc() : super(InitEditItemState.initial()) {
    on<LoadEditProductDataEvent>(fetchData);
  }

  Future<void> fetchData(
      LoadEditProductDataEvent event, Emitter<InitEditItemState> emit) async {
    emit(state.copyWith(fetchState: FetchState.loading));

    Map data = await editRepository
        .getSalerProductInfo(event.productId)
        .catchError((e) {
      emit(state.copyWith(fetchState: FetchState.failure));
      return;
    });

    emit(state.copyWith(fetchState: FetchState.success, data: data));
  }

  void putData() {}
}
