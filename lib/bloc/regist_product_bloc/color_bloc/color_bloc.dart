import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState.initial()) {
    on<ClickColorButtonEvent>(clickColorButton);
  }

  void clickColorButton(ClickColorButtonEvent event, Emitter<ColorState> emit) {
    List<String> colorList = [...state.selectedColors];
    if (colorList.contains(event.color)) {
      colorList.remove(event.color);
      emit(state.copyWith(selectedColors: colorList));
    } else {
      colorList.add(event.color);
      emit(state.copyWith(selectedColors: colorList));
    }
  }
}
