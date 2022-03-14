part of 'price_per_option_bloc.dart';

abstract class PricePerOptionEvent extends Equatable {
  const PricePerOptionEvent();

  @override
  List<Object> get props => [];
}

class ClickedShowPricePerOptionEvent extends PricePerOptionEvent {}

class ClickedRemovePricePerOptionEvent extends PricePerOptionEvent {
  final int index;

  const ClickedRemovePricePerOptionEvent(this.index);
}

class ChangePricePerOptionEvent extends PricePerOptionEvent {
  final int index;
  final String changePrice;
  const ChangePricePerOptionEvent({
    required this.index,
    required this.changePrice,
  });
}

class InputInventoryEvent extends PricePerOptionEvent {
  final int index;
  final int inventory;
  const InputInventoryEvent({
    required this.index,
    required this.inventory,
  });
}
