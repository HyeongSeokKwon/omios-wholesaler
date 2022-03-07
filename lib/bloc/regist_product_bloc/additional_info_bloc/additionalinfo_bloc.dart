import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'additionalinfo_event.dart';
part 'additionalinfo_state.dart';

class AdditionalInfoBloc
    extends Bloc<AdditionalInfoEvent, AdditionalInfoState> {
  AdditionalInfoBloc() : super(AdditionalInfoState.initial()) {
    on<ClickAdditionalInfoEvent>(clickAdditionalInfo);
  }

  void clickAdditionalInfo(
      ClickAdditionalInfoEvent event, Emitter<AdditionalInfoState> emit) {
    Map<String, String> copy = {...state.selectedAdditionalInfo};
    switch (event.type) {
      case "두께감":
        copy['두께감'] = state.thicknessList[event.index];
        break;
      case "비침":
        copy['비침'] = state.seeThroughList[event.index];
        break;
      case "신축성":
        copy['신축성'] = state.elasticityList[event.index];
        break;
      case "안감":
        copy['안감'] = state.liningList[event.index];

        break;
      default:
    }
    print(copy);
    emit(state.copyWith(selectedAdditionalInfo: copy));
  }
}
