import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'regist_product_event.dart';
part 'regist_product_state.dart';

class RegistProductBloc extends Bloc<RegistProductEvent, RegistProductState> {
  RegistProductBloc() : super(RegistProductState.initial()) {
    on<RegistProductEvent>((event, emit) {});
  }
}
