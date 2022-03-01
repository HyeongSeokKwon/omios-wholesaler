import 'package:deepy_wholesaler/repository/products_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'myproducts_event.dart';
part 'myproducts_state.dart';

class MyproductsBloc extends Bloc<MyproductsEvent, MyproductsState> {
  final ProductsRepository productsRepository;
  MyproductsBloc({required this.productsRepository})
      : super(MyproductsState.initial()) {
    on<LoadMyproductsEvent>(getMyproducts);
  }

  Future<void> getMyproducts(
      LoadMyproductsEvent event, Emitter<MyproductsState> emit) async {
    List<dynamic> myproductsData =
        await productsRepository.getMyproducts().catchError((e) {
      emit(state.copyWith(fetchStatus: FetchStatus.error));
    });
    emit(state.copyWith(
        productsData: myproductsData, fetchStatus: FetchStatus.fetched));
  }
}
