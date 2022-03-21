import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'style_event.dart';
part 'style_state.dart';

class StyleBloc extends Bloc<StyleEvent, StyleState> {
  StyleBloc() : super(StyleState.initial()) {
    on<ClickStyleButtonEvent>(clickStyleButton);
  }

  void clickStyleButton(ClickStyleButtonEvent event, Emitter<StyleState> emit) {
    emit(state.copyWith(
      selectedStyle: state.styleList[event.styleIndex],
    ));
  }
}
