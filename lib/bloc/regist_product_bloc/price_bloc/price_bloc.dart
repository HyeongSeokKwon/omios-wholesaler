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
    event.priceEditController.text = changedPrice.toString();
    emit(state.copyWith(price: changedPrice.toString()));
  }

  void changePrice(ChangePriceEvent event, Emitter<PriceState> emit) {
    print(event.changePrice);
    emit(state.copyWith(price: event.changePrice));
  }
}
