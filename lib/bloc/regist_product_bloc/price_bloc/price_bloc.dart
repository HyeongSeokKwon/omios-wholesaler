import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceBloc() : super(PriceState.initial()) {
    on<ChangePriceEvent>(changePrice);
    on<ClickAddButtonEvent>(clickAddButton);
  }

  void clickAddButton(ClickAddButtonEvent event, Emitter<PriceState> emit) {
    int changedPrice = int.parse(state.price) + event.addPrice;
    int retailPrice = caculateRetailPrice(changedPrice);
    event.priceEditController.text = changedPrice.toString();

    emit(state.copyWith(
        price: changedPrice.toString(), retailPrice: retailPrice.toString()));
  }

  void changePrice(ChangePriceEvent event, Emitter<PriceState> emit) {
    int retailPrice;
    if (event.changePrice.isNotEmpty) {
      retailPrice = caculateRetailPrice(int.parse(event.changePrice));
      emit(state.copyWith(
          price: event.changePrice.toString(),
          retailPrice: retailPrice.toString()));
    } else {
      retailPrice = 0;
      emit(state.copyWith(
          price: 0.toString(), retailPrice: retailPrice.toString()));
    }
  }

  int caculateRetailPrice(int price) {
    if (price > 0 && price < 4000) {
      return price + 4000;
    } else if (price >= 4000 && price < 10000) {
      return (price * 2).toInt();
    } else if (price >= 10000 && price < 30000) {
      return (price * 1.9).toInt();
    } else if (price >= 30000 && price < 50000) {
      return (price * 1.8).toInt();
    } else if (price >= 50000) {
      return (price * 1.7).toInt();
    } else {
      return 0;
    }
  }
}
