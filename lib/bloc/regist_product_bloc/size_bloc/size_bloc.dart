import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'size_event.dart';
part 'size_state.dart';

class SizeBloc extends Bloc<SizeEvent, SizeState> {
  SizeBloc() : super(SizeState.initial()) {
    on<ClickSizeButton>(addSelectedSize);
    on<ClickRemoveSizeButton>(removeSize);
  }

  void addSelectedSize(ClickSizeButton event, Emitter<SizeState> emit) {
    List<String> copySelectedList = [];
    List<Map> copySelectedMap = [];
    copySelectedList.addAll(state.selectedSize);
    for (var value in state.selectedSizeMap) {
      copySelectedMap.add(Map.from(value));
    }
    switch (event.size) {
      default:
        copySelectedList.add(event.size);
        copySelectedMap.add({"name": event.size, "id": event.sizeId});
        break;
    }
    emit(state.copyWith(
        selectedSize: copySelectedList, selectedSizeMap: copySelectedMap));
  }

  void removeSize(ClickRemoveSizeButton event, Emitter<SizeState> emit) {
    List<String> copySelectedList = [];
    List<Map> copySelectedMap = [];
    copySelectedList.addAll(state.selectedSize);
    for (var value in state.selectedSizeMap) {
      copySelectedMap.add(Map.from(value));
    }

    switch (event.size) {
      case 'S-M':
        state.selectedSize
            .removeWhere((element) => element == 'S' && element == 'M');
        for (var value in state.selectedSizeMap) {
          if (value['size'] == 'S' || value['size'] == 'M') {
            copySelectedMap.remove(value);
          }
        }
        break;
      case 'S-L':
        state.selectedSize.removeWhere(
            (element) => element == 'S' && element == 'M' && element == 'L');
        for (var value in state.selectedSizeMap) {
          if (value['size'] == 'S' ||
              value['size'] == 'M' ||
              value['size'] == 'L') {
            copySelectedMap.remove(value);
          }
        }
        break;
      case 'S-XL':
        state.selectedSize.removeWhere((element) =>
            element == 'S' &&
            element == 'M' &&
            element == 'L' &&
            element == 'XL');
        for (var value in state.selectedSizeMap) {
          if (value['size'] == 'S' ||
              value['size'] == 'M' ||
              value['size'] == 'L' ||
              value['size'] == 'XL') {
            copySelectedMap.remove(value);
          }
        }

        break;
      default:
        copySelectedList.remove(event.size);
        copySelectedMap.removeWhere((element) => element['name'] == event.size);

        break;
    }
    emit(state.copyWith(
        selectedSize: copySelectedList, selectedSizeMap: copySelectedMap));
  }
}
