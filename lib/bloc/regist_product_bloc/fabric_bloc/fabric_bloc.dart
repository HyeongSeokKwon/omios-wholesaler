import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'fabric_event.dart';
part 'fabric_state.dart';

class FabricBloc extends Bloc<FabricEvent, FabricState> {
  FabricBloc() : super(FabricState.initial()) {
    on<ClickFabricButtonEvent>(clickFabricButton);
    on<InputFabricPercentEvent>(inputFabricPercent);
    on<EditFabricsNameEvent>(editFabricName);
  }

  void clickFabricButton(
      ClickFabricButtonEvent event, Emitter<FabricState> emit) {
    List<Map> copy = [...state.selectedFabric];
    List<bool> copyIsClicked = [...state.isClicked];
    int sum = state.sum;
    if (event.isChecked) {
      copy.add({
        "name": state.fabricList[event.fabricIndex]['name'],
        "fabricId": event.fabricIndex + 1,
        "percent": state.textController[event.fabricIndex].text.isNotEmpty
            ? int.parse(state.textController[event.fabricIndex].text)
            : 0,
        // state.textController![event.fabricIndex].text.isNotEmpty
        //     ? int.parse(state.textController![event.fabricIndex].text)
        //     : 0
      });
    } else {
      state.textController[event.fabricIndex].text = "";
      for (var value in copy) {
        if (value["fabricId"] == event.fabricIndex + 1) {
          sum -= value["percent"] as int;
          copy.remove(value);

          break;
        }
      }
    }

    copyIsClicked[event.fabricIndex] = event.isChecked;

    emit(state.copyWith(
        selectedFabric: copy, isClicked: copyIsClicked, sum: sum));
  }

  void editFabricName(EditFabricsNameEvent event, Emitter<FabricState> emit) {
    List<Map> copy = [...state.fabricList];

    copy[event.fabricIndex]['name'] = event.fabricName;
    emit(state.copyWith(fabricList: copy));
  }

  void inputFabricPercent(
      InputFabricPercentEvent event, Emitter<FabricState> emit) {
    List<Map<String, dynamic>> copy = [];
    int sum = 0;

    if (event.fabricPercent.isNotEmpty) {
      for (var value in state.selectedFabric) {
        copy.add(Map.from(value));
      }

      for (var value in copy) {
        if (value['fabricId'] == event.fabricIndex + 1) {
          value['percent'] = int.parse(event.fabricPercent);
          break;
        }
      }

      for (var value in copy) {
        sum += value['percent'] as int;
      }
      emit(state.copyWith(selectedFabric: copy, sum: sum));
    }
  }

  void checkFabricSum(CheckFabricsSumEvent event, Emitter<FabricState> emit) {}
}
