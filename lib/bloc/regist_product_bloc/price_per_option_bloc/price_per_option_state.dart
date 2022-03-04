part of 'price_per_option_bloc.dart';

class PricePerOptionState extends Equatable {
  List<Map<String, dynamic>> pricePerOptionList;
  bool isClicked;
  PricePerOptionState(
      {required this.pricePerOptionList, required this.isClicked});

  factory PricePerOptionState.initial() {
    return PricePerOptionState(pricePerOptionList: [], isClicked: false);
  }

  @override
  List<Object> get props => [pricePerOptionList, isClicked];

  PricePerOptionState copyWith({
    List<Map<String, dynamic>>? pricePerOptionList,
    bool? isClicked,
  }) {
    return PricePerOptionState(
      pricePerOptionList: pricePerOptionList ?? this.pricePerOptionList,
      isClicked: isClicked ?? this.isClicked,
    );
  }
}
