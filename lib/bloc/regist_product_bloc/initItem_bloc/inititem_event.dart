part of 'inititem_bloc.dart';

abstract class InititemEvent extends Equatable {
  const InititemEvent();

  @override
  List<Object> get props => [];
}

class FetchInitDynamicInfoEvent extends InititemEvent {}

class FetchInitCommonInfoEvent extends InititemEvent {}
