import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'fabric_event.dart';
part 'fabric_state.dart';

class FabricBloc extends Bloc<FabricEvent, FabricState> {
  FabricBloc() : super(FabricState.initial()) {
    on<ClickFabricButtonEvent>(clickFabricButton);
    on<InputFabricPercentEvent>(inputFabricPercent);
  }

  void clickFabricButton(
      ClickFabricButtonEvent event, Emitter<FabricState> emit) {
    List<Map> copy = [...state.selectedFabric];
    List<bool> copyIsClicked = List.from(state.isClicked);

    if (event.isChecked) {
      copy.add({
        "fabric": event.fabric,
        "fabricId": event.fabricIndex,
        "percent": 0
      });
    } else {
      for (var value in copy) {
        if (value["fabric"] == event.fabric) {
          copy.remove(value);
          break;
        }
      }
    }

    copyIsClicked[event.fabricIndex] = event.isChecked;
    emit(state.copyWith(selectedFabric: copy, isClicked: copyIsClicked));
  }

  void inputFabricPercent(
      InputFabricPercentEvent event, Emitter<FabricState> emit) {
    List<Map<String, dynamic>> copy = [];
    for (var value in state.selectedFabric) {
      copy.add(Map.from(value));
    }

    for (var value in copy) {
      if (value['fabricId'] == event.fabricIndex) {
        value['fabricPercent'] = int.parse(event.fabricPercent);
        break;
      }
    }
    emit(state.copyWith(selectedFabric: copy));
  }
}
