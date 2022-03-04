import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState.initial()) {
    on<ClickColorButtonEvent>(clickColorButton);
  }

  void clickColorButton(ClickColorButtonEvent event, Emitter<ColorState> emit) {
    List<Map> colorMap = [...state.selectedColorMap];
    List<String> colorList = [...state.selectedColorList];

    for (var color in colorMap) {
      if (color['color'] == event.color) {
        colorMap.remove(color);
        colorList.remove(color['color']);
        emit(state.copyWith(
            selectedColorMap: colorMap, selectedColorList: colorList));
        return;
      }
    }
    colorMap
        .add({'color': event.color, 'colorId': event.colorId, 'images': null});
    colorList.add(event.color);
    emit(state.copyWith(
        selectedColorMap: colorMap, selectedColorList: colorList));
    return;
  }
}
