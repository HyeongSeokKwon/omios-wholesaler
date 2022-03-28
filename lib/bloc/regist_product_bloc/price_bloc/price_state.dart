part of 'price_bloc.dart';

// ignore: must_be_immutable
class PriceState extends Equatable {
  String price;
  TextEditingController textEditingController;
  PriceState({
    required this.price,
    required this.textEditingController,
  });

  factory PriceState.initial() {
    return PriceState(
        price: 0.toString(), textEditingController: TextEditingController());
  }

  PriceState copyWith({
    String? price,
    TextEditingController? textEditingController,
  }) {
    return PriceState(
      price: price ?? this.price,
      textEditingController:
          textEditingController ?? this.textEditingController,
    );
  }

  @override
  List<Object> get props => [price, textEditingController];
}
