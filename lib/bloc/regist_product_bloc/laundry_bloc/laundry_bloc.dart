import 'package:bloc/bloc.dart';
import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'laundry_event.dart';
part 'laundry_state.dart';

class LaundryBloc extends Bloc<LaundryEvent, LaundryState> {
  LaundryBloc() : super(LaundryState.initial()) {
    on<ClickLaudnryButtonEvent>(clickLaundryButton);
  }

  void clickLaundryButton(
      ClickLaudnryButtonEvent event, Emitter<LaundryState> emit) {
    List<Map> copy = [...state.selectedLaundry];
    for (var laundry in copy) {
      if (laundry['name'] == state.washingList[event.laundryIndex]['name']) {
        copy.remove(laundry);
        emit(state.copyWith(selectedLaundry: copy));
        return;
      }
    }
    copy.add(state.washingList[event.laundryIndex]);

    emit(state.copyWith(selectedLaundry: copy));
    return;
  }
}
