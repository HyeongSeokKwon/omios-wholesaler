import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'laundry_event.dart';
part 'laundry_state.dart';

class LaundryBloc extends Bloc<LaundryEvent, LaundryState> {
  LaundryBloc() : super(LaundryState.initial()) {
    on<ClickLaudnryButtonEvent>(clickLaundryButton);
  }

  void clickLaundryButton(
      ClickLaudnryButtonEvent event, Emitter<LaundryState> emit) {
    List<String> copy = [...state.selectedLaundry];

    if (copy.contains(event.laundryType)) {
      copy.remove(event.laundryType);
    } else {
      copy.add(event.laundryType);
    }
    print(copy);
    emit(state.copyWith(selectedLaundry: copy));
  }
}
