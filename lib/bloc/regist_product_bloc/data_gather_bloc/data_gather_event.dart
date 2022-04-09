part of 'data_gather_bloc.dart';

abstract class DataGatherEvent extends Equatable {
  const DataGatherEvent();

  @override
  List<Object> get props => [];
}

class RegistEvent extends DataGatherEvent {
  final RegistMode registMode;
  const RegistEvent({
    required this.registMode,
  });
}

class CombineDataEvent extends DataGatherEvent {
  final RegistMode registMode;
  final String? callState;
  const CombineDataEvent({
    required this.registMode,
    this.callState,
  });
}
