import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'age_group_event.dart';
part 'age_group_state.dart';

class AgeGroupBloc extends Bloc<AgeGroupEvent, AgeGroupState> {
  AgeGroupBloc() : super(AgeGroupState.initial()) {
    on<ClickAgeGroupButtonEvent>(clickAgeGroupButton);
  }

  void clickAgeGroupButton(
      ClickAgeGroupButtonEvent event, Emitter<AgeGroupState> emit) {
    if (state.ageGroupList[event.index]['id'] == state.selectedAgeGroupId) {
      emit(state.copyWith(selectedAgeGroupId: -1));
    } else {
      emit(state.copyWith(
          selectedAgeGroupId: state.ageGroupList[event.index]['id']));
    }
  }
}
