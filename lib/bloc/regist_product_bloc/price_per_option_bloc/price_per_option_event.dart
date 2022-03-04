part of 'price_per_option_bloc.dart';

abstract class PricePerOptionEvent extends Equatable {
  const PricePerOptionEvent();

  @override
  List<Object> get props => [];
}

class ClickedShowPricePerOptionEvent extends PricePerOptionEvent {
  final bool isClicked;
  const ClickedShowPricePerOptionEvent({
    required this.isClicked,
  });
}

class ClickPlusPriceButtonEvent extends PricePerOptionEvent {
  final int index;
  const ClickPlusPriceButtonEvent({
    required this.index,
  });
}

class ClickMinusPriceButtonEvent extends PricePerOptionEvent {
  final int index;
  const ClickMinusPriceButtonEvent({
    required this.index,
  });
}
