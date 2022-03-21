import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'name_event.dart';
part 'name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  NameBloc() : super(NameState.initial()) {
    on<ChangeNameEvent>(changeName);
  }

  void changeName(ChangeNameEvent event, Emitter<NameState> emit) {
    String errorMessage = "";
    if (event.name.isEmpty) {
      errorMessage = "상품명을 입력해주세요";
    }
    emit(state.copyWith(name: event.name, errorMessage: errorMessage));
  }
}
