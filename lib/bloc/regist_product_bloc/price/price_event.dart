part of 'price_bloc.dart';

abstract class PriceEvent extends Equatable {
  const PriceEvent();

  @override
  List<Object> get props => [];
}

class ChangePriceEvent extends PriceEvent {
  final String changePrice;
  const ChangePriceEvent({required this.changePrice});
}

class ClickAddButtonEvent extends PriceEvent {
  final int addPrice;
  final TextEditingController priceEditController;
  const ClickAddButtonEvent(
      {required this.addPrice, required this.priceEditController});
}
