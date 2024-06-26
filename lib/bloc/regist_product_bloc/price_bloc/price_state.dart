part of 'price_bloc.dart';

// ignore: must_be_immutable
class PriceState extends Equatable {
  String price;
  String retailPrice;
  TextEditingController textEditingController;
  PriceState({
    required this.price,
    required this.retailPrice,
    required this.textEditingController,
  });

  factory PriceState.initial() {
    return PriceState(
        price: 0.toString(),
        retailPrice: 0.toString(),
        textEditingController: TextEditingController());
  }

  PriceState copyWith({
    String? price,
    String? retailPrice,
    TextEditingController? textEditingController,
  }) {
    return PriceState(
      price: price ?? this.price,
      retailPrice: retailPrice ?? this.retailPrice,
      textEditingController:
          textEditingController ?? this.textEditingController,
    );
  }

  @override
  List<Object> get props => [price, retailPrice, textEditingController];
}
