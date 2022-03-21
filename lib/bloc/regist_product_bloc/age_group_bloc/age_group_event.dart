part of 'age_group_bloc.dart';

abstract class AgeGroupEvent extends Equatable {
  const AgeGroupEvent();

  @override
  List<Object> get props => [];
}

class ClickAgeGroupButtonEvent extends AgeGroupEvent {
  final int index;
  const ClickAgeGroupButtonEvent({
    required this.index,
  });
}
