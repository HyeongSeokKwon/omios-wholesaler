part of 'price_bloc.dart';

class PriceState extends Equatable {
  final String price;
  const PriceState({
    required this.price,
  });

  factory PriceState.initial() {
    return PriceState(price: 0.toString());
  }

  PriceState copyWith({
    String? price,
  }) {
    return PriceState(
      price: price ?? this.price,
    );
  }

  @override
  List<Object> get props => [price];
}
