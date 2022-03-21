part of 'price_per_option_bloc.dart';

class PricePerOptionState extends Equatable {
  List<Map<String, dynamic>> pricePerOptionList;
  Set<int> inappositePriceIndexList;
  List<TextEditingController> priceControllerList;
  List<TextEditingController> inventoryControllerList;
  PricePerOptionState(
      {required this.pricePerOptionList,
      required this.inappositePriceIndexList,
      required this.priceControllerList,
      required this.inventoryControllerList});

  factory PricePerOptionState.initial() {
    return PricePerOptionState(
        pricePerOptionList: const [],
        inappositePriceIndexList: const {},
        priceControllerList: const [],
        inventoryControllerList: const []);
  }

  @override
  List<Object> get props => [pricePerOptionList, inappositePriceIndexList];

  PricePerOptionState copyWith({
    List<Map<String, dynamic>>? pricePerOptionList,
    Set<int>? inappositePriceIndexList,
    List<TextEditingController>? priceControllerList,
    List<TextEditingController>? inventoryControllerList,
  }) {
    return PricePerOptionState(
      pricePerOptionList: pricePerOptionList ?? this.pricePerOptionList,
      inappositePriceIndexList:
          inappositePriceIndexList ?? this.inappositePriceIndexList,
      priceControllerList: priceControllerList ?? this.priceControllerList,
      inventoryControllerList:
          inventoryControllerList ?? this.inventoryControllerList,
    );
  }
}
