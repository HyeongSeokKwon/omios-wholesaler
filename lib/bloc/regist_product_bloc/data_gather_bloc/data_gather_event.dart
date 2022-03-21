part of 'data_gather_bloc.dart';

abstract class DataGatherEvent extends Equatable {
  const DataGatherEvent();

  @override
  List<Object> get props => [];
}

class ClickRegistButtonEvent extends DataGatherEvent {}
