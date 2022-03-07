import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'style_event.dart';
part 'style_state.dart';

class StyleBloc extends Bloc<StyleEvent, StyleState> {
  StyleBloc() : super(StyleState.initial()) {
    on<ClickStyleButtonEvent>(clickStyleButton);
  }

  void clickStyleButton(ClickStyleButtonEvent event, Emitter<StyleState> emit) {
    List<String> copy = [...state.selectedStyle];
    List<bool> isClicked = [...state.isClicked];
    String selectedStyle = state.styleList[event.styleIndex];

    if (copy.contains(selectedStyle)) {
      copy.remove(selectedStyle);
    } else {
      copy.add(selectedStyle);
    }

    isClicked[event.styleIndex] = !isClicked[event.styleIndex];

    emit(state.copyWith(selectedStyle: copy, isClicked: isClicked));
  }
}
