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
    Map<String, Map> copy = {};

    copy.addAll(state.selectedAdditionalInfo);
    switch (event.type) {
      case "thickness":
        copy['thickness'] = state.thicknessList![event.index];
        break;
      case "see_through":
        copy['see_through'] = state.seeThroughList![event.index];
        break;
      case "flexibility":
        copy['flexibility'] = state.elasticityList![event.index];
        break;
      case "lining":
        copy['lining'] = state.liningList![event.index];

        break;
      default:
        break;
    }
    emit(state.copyWith(
      selectedAdditionalInfo: copy,
    ));
  }
}
