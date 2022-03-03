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

    copySelectedList.addAll(state.selectedSize);
    switch (event.size) {
      case 'S-M':
        if (!copySelectedList.contains('S')) {
          copySelectedList.add("S");
        }
        if (!copySelectedList.contains('M')) {
          copySelectedList.add("M");
        }
        break;
      case 'S-L':
        if (!copySelectedList.contains('S')) {
          copySelectedList.add("S");
        }
        if (!copySelectedList.contains('M')) {
          copySelectedList.add("M");
        }
        if (!copySelectedList.contains('L')) {
          copySelectedList.add("L");
        }
        break;
      case 'S-XL':
        if (!copySelectedList.contains('S')) {
          copySelectedList.add("S");
        }
        if (!copySelectedList.contains('M')) {
          copySelectedList.add("M");
        }
        if (!copySelectedList.contains('L')) {
          copySelectedList.add("L");
        }
        if (!copySelectedList.contains('XL')) {
          copySelectedList.add("XL");
        }
        break;
      default:
        copySelectedList.add(event.size);
        break;
    }

    emit(state.copyWith(selectedSize: copySelectedList));
  }

  void removeSize(ClickRemoveSizeButton event, Emitter<SizeState> emit) {
    List<String> copySelectedList = [];

    copySelectedList.addAll(state.selectedSize);

    switch (event.size) {
      case 'S-M':
        state.selectedSize
            .removeWhere((element) => element == 'S' && element == 'M');
        break;
      case 'S-L':
        state.selectedSize.removeWhere(
            (element) => element == 'S' && element == 'M' && element == 'L');
        break;
      case 'S-XL':
        state.selectedSize.removeWhere((element) =>
            element == 'S' &&
            element == 'M' &&
            element == 'L' &&
            element == 'XL');

        break;
      default:
        copySelectedList.remove(event.size);
        break;
    }
    emit(state.copyWith(selectedSize: copySelectedList));
  }
}
