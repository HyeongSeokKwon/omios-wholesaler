part of 'laundry_bloc.dart';

abstract class LaundryEvent extends Equatable {
  const LaundryEvent();

  @override
  List<Object> get props => [];
}

class ClickLaudnryButtonEvent extends LaundryEvent {
  final int laundryIndex;

  const ClickLaudnryButtonEvent({
    required this.laundryIndex,
  });
}

class InitWashingListEvent extends LaundryEvent {}
