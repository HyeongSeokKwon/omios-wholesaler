part of 'additionalinfo_bloc.dart';

abstract class AdditionalInfoEvent extends Equatable {
  const AdditionalInfoEvent();

  @override
  List<Object> get props => [];
}

class ClickAdditionalInfoEvent extends AdditionalInfoEvent {
  int index;
  String type;
  ClickAdditionalInfoEvent({
    required this.index,
    required this.type,
  });
}
