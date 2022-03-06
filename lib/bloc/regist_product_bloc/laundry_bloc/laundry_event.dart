part of 'laundry_bloc.dart';

abstract class LaundryEvent extends Equatable {
  const LaundryEvent();

  @override
  List<Object> get props => [];
}

class ClickLaudnryButtonEvent extends LaundryEvent {
  final String laundryType;

  const ClickLaudnryButtonEvent({
    required this.laundryType,
  });
}
