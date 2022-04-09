import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState.initial()) {
    on<ClickColorAddButtonEvent>(addColor);
    on<ClickColorRemoveButtonEvent>(removeColor);
    on<ChangeColorCustomedNameEvent>(changeColorCustomedName);
  }

  void addColor(ClickColorAddButtonEvent event, Emitter<ColorState> emit) {
    List<Map<String, dynamic>> colorMap = [...state.selectedColorMap];
    List<String> colorList = [...state.selectedColorList];
    if (colorMap.length < 10) {
      colorMap.add({
        'color': event.color,
        'colorId': event.colorId,
        'customedName': event.customedName,
        'images': null
      });
      colorList.add(event.color);
      colorMap.sort((a, b) => (a['colorId']).compareTo(b['colorId']));

      emit(state.copyWith(
          selectedColorMap: colorMap,
          selectedColorList: colorList,
          errorMessage:
              checkDuplicated(colorMap) == false ? "" : "중복된 색상명이 존재합니다"));
    }
  }

  void removeColor(
      ClickColorRemoveButtonEvent event, Emitter<ColorState> emit) {
    List<Map<String, dynamic>> colorMap = [...state.selectedColorMap];
    List<String> colorList = [...state.selectedColorList];

    for (var color in colorMap) {
      if (color['color'] == event.color) {
        colorMap.remove(color);
        colorList.remove(color['color']);
        emit(state.copyWith(
            selectedColorMap: colorMap,
            selectedColorList: colorList,
            errorMessage:
                checkDuplicated(colorMap) == false ? "" : "중복된 색상명이 존재합니다"));
        return;
      }
    }
  }

  void changeColorCustomedName(
      ChangeColorCustomedNameEvent event, Emitter<ColorState> emit) {
    List<Map<String, dynamic>> colorMap = [];
    for (var map in state.selectedColorMap) {
      colorMap.add(Map.from(map));
    }

    for (var color in colorMap) {
      if (mapEquals(color, state.selectedColorMap[event.selectedColorIndex])) {
        colorMap[event.selectedColorIndex]['customedName'] = event.customedName;
        emit(state.copyWith(
            selectedColorMap: colorMap,
            errorMessage:
                checkDuplicated(colorMap) == false ? "" : "중복된 색상명이 존재합니다"));
        break;
      }
    }
  }

  bool checkDuplicated(List selectedColors) {
    List checkList = [];
    for (var element in selectedColors) {
      if (checkList.contains(element['customedName'])) {
        return true;
      } else {
        checkList.add(element['customedName']);
      }
    }
    return false;
  }
}
