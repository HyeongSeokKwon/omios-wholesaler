part of 'price_per_option_bloc.dart';

class PricePerOptionState extends Equatable {
  List<Map<String, dynamic>> pricePerOptionList;
  Set<int> inappositePriceIndexList;
  List<TextEditingController> inventoryControllerList;
  PricePerOptionState(
      {required this.pricePerOptionList,
      required this.inappositePriceIndexList,
      required this.inventoryControllerList});

  factory PricePerOptionState.initial() {
    return PricePerOptionState(
        pricePerOptionList: [],
        inappositePriceIndexList: const {},
        inventoryControllerList: []);
  }

  @override
  List<Object> get props => [pricePerOptionList, inappositePriceIndexList];

  PricePerOptionState copyWith({
    List<Map<String, dynamic>>? pricePerOptionList,
    Set<int>? inappositePriceIndexList,
    List<TextEditingController>? inventoryControllerList,
  }) {
    return PricePerOptionState(
      pricePerOptionList: pricePerOptionList ?? this.pricePerOptionList,
      inappositePriceIndexList:
          inappositePriceIndexList ?? this.inappositePriceIndexList,
      inventoryControllerList:
          inventoryControllerList ?? this.inventoryControllerList,
    );
  }
}
