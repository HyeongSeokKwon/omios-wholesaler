import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'price_per_option_event.dart';
part 'price_per_option_state.dart';

class PricePerOptionBloc
    extends Bloc<PricePerOptionEvent, PricePerOptionState> {
  final ColorBloc colorBloc;
  final PriceBloc priceBloc;
  final SizeBloc sizeBloc;

  late final StreamSubscription colorSubScription;
  late final StreamSubscription sizeSubScription;
  late final StreamSubscription priceSubScription;
  PricePerOptionBloc(this.colorBloc, this.priceBloc, this.sizeBloc)
      : super(PricePerOptionState.initial()) {
    priceSubScription = priceBloc.stream.listen((PriceState priceState) {
      add(ClickedShowPricePerOptionEvent());
    });

    colorSubScription = colorBloc.stream.listen((ColorState colorState) {
      add(ClickedShowPricePerOptionEvent());
    });

    sizeSubScription = sizeBloc.stream.listen((SizeState sizeState) {
      add(ClickedShowPricePerOptionEvent());
    });

    on<ClickedShowPricePerOptionEvent>(createPricePerOptionList);
    on<ChangePricePerOptionEvent>(changePrice);
    on<ClickedRemovePricePerOptionEvent>(removePricePerOption);
    on<InputInventoryEvent>(changeInventory);
  }

  void sizeInfoChanged() {}

  void colorInfoChanged() {}

  void createPricePerOptionList(
      ClickedShowPricePerOptionEvent event, Emitter<PricePerOptionState> emit) {
    List<Map<String, dynamic>> pricePerOptionList = [];
    List<TextEditingController> priceControllerList;
    List<TextEditingController> inventoryControllerList;
    colorBloc.state.selectedColorMap
        .sort((a, b) => (a['colorId']).compareTo(b['colorId']));

    sizeBloc.state.selectedSizeMap.sort((a, b) => (a['id']).compareTo(b['id']));
    for (var color in colorBloc.state.selectedColorMap) {
      for (var size in sizeBloc.state.selectedSizeMap) {
        pricePerOptionList.add(
          {
            'color': color,
            'size': size,
            'price': priceBloc.state.price,
            'price_difference': 0,
            'inventory': 0
          },
        );
      }
    }

    priceControllerList = List.generate(
        pricePerOptionList.length, (index) => TextEditingController());

    inventoryControllerList = List.generate(
        pricePerOptionList.length, (index) => TextEditingController());

    for (int index = 0; index < priceControllerList.length; index++) {
      priceControllerList[index].text =
          pricePerOptionList[index]['price'].toString();
      inventoryControllerList[index].text =
          pricePerOptionList[index]['inventory'].toString();
    }

    emit(state.copyWith(
      pricePerOptionList: pricePerOptionList,
      priceControllerList: priceControllerList,
      inventoryControllerList: inventoryControllerList,
    ));
  }

  void removePricePerOption(ClickedRemovePricePerOptionEvent event,
      Emitter<PricePerOptionState> emit) {
    List<Map<String, dynamic>> copy = [];
    for (var value in state.pricePerOptionList) {
      copy.add(Map.from(value));
    }
    copy.removeAt(event.index);

    state.priceControllerList.removeAt(event.index);
    state.inventoryControllerList.removeAt(event.index);

    emit(state.copyWith(pricePerOptionList: copy));
  }

  void changePrice(
      ChangePricePerOptionEvent event, Emitter<PricePerOptionState> emit) {
    List<Map<String, dynamic>> copy = [];
    Set<int> inappositePriceIndexList = {};
    int standardPrice = int.parse(priceBloc.state.price);
    int minPrice = (standardPrice * 0.8).toInt();
    int maxPrice = (standardPrice * 1.2).toInt();

    for (var value in state.pricePerOptionList) {
      copy.add(Map.from(value));
    }
    inappositePriceIndexList.addAll(state.inappositePriceIndexList);

    if (int.parse(event.changePrice) >= minPrice &&
        int.parse(event.changePrice) <= maxPrice) {
      copy[event.index]['price'] = int.parse(event.changePrice);
      copy[event.index]['price_difference'] =
          (standardPrice - copy[event.index]['price']).abs();

      if (inappositePriceIndexList.contains(event.index)) {
        inappositePriceIndexList.remove(event.index);
      }
    } else {
      inappositePriceIndexList.add(event.index);
    }
    emit(state.copyWith(
        pricePerOptionList: copy,
        inappositePriceIndexList: inappositePriceIndexList));
  }

  void changeInventory(
      InputInventoryEvent event, Emitter<PricePerOptionState> emit) {
    List<Map<String, dynamic>> copy = [];
    for (var value in state.pricePerOptionList) {
      copy.add(Map.from(value));
    }

    copy[event.index]['inventory'] = event.inventory;

    emit(state.copyWith(pricePerOptionList: copy));
  }

  @override
  Future<void> close() {
    colorSubScription.cancel();
    sizeSubScription.cancel();
    return super.close();
  }
}
