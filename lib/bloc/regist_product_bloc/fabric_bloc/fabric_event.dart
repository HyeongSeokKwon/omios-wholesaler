part of 'fabric_bloc.dart';

abstract class FabricEvent extends Equatable {
  const FabricEvent();

  @override
  List<Object> get props => [];
}

class ClickFabricButtonEvent extends FabricEvent {
  final bool isChecked;
  final String fabric;
  final int fabricIndex;

  const ClickFabricButtonEvent({
    required this.isChecked,
    required this.fabric,
    required this.fabricIndex,
  });
}

class InputFabricPercentEvent extends FabricEvent {
  final String fabricPercent;
  final int fabricIndex;
  const InputFabricPercentEvent({
    required this.fabricPercent,
    required this.fabricIndex,
  });
}
