part of 'price_per_option_bloc.dart';

class PricePerOptionState extends Equatable {
  List<Map<String, dynamic>> pricePerOptionList;
  List<TextEditingController> priceControllerList;
  List<TextEditingController> inventoryControllerList;
  PricePerOptionState(
      {required this.pricePerOptionList,
      required this.priceControllerList,
      required this.inventoryControllerList});

  factory PricePerOptionState.initial() {
    return PricePerOptionState(
        pricePerOptionList: [],
        priceControllerList: [],
        inventoryControllerList: []);
  }

  @override
  List<Object> get props => [pricePerOptionList];

  PricePerOptionState copyWith({
    List<Map<String, dynamic>>? pricePerOptionList,
    List<TextEditingController>? priceControllerList,
    List<TextEditingController>? inventoryControllerList,
  }) {
    return PricePerOptionState(
      pricePerOptionList: pricePerOptionList ?? this.pricePerOptionList,
      priceControllerList: priceControllerList ?? this.priceControllerList,
      inventoryControllerList:
          inventoryControllerList ?? this.inventoryControllerList,
    );
  }
}
