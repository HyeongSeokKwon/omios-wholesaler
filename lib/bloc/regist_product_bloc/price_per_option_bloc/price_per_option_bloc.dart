import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:deepy_wholesaler/bloc/bloc.dart';
part 'price_per_option_event.dart';
part 'price_per_option_state.dart';

class PricePerOptionBloc
    extends Bloc<PricePerOptionEvent, PricePerOptionState> {
  final ColorBloc colorBloc;
  final PriceBloc priceBloc;
  final SizeBloc sizeBloc;

  late final StreamSubscription colorSubScription;
  late final StreamSubscription sizeSubScription;

  PricePerOptionBloc(this.colorBloc, this.priceBloc, this.sizeBloc)
      : super(PricePerOptionState.initial()) {
    colorSubScription = colorBloc.stream.listen((ColorState colorState) {
      if (state.isClicked) {
        add(ClickedShowPricePerOptionEvent(isClicked: state.isClicked));
      }
      if (colorState.selectedColorList.isEmpty) {
        add(const ClickedShowPricePerOptionEvent(isClicked: false));
      }
    });

    sizeSubScription = sizeBloc.stream.listen((SizeState sizeState) {
      if (state.isClicked) {
        add(ClickedShowPricePerOptionEvent(isClicked: state.isClicked));
      }
      if (sizeState.selectedSize.isEmpty) {
        add(const ClickedShowPricePerOptionEvent(isClicked: false));
      }
    });

    on<ClickedShowPricePerOptionEvent>(createPricePerOptionList);
    on<ClickPlusPriceButtonEvent>(addPrice);
    on<ClickMinusPriceButtonEvent>(substractPrice);
  }

  void createPricePerOptionList(
      ClickedShowPricePerOptionEvent event, Emitter<PricePerOptionState> emit) {
    List<Map<String, dynamic>> pricePerOptionList = [];
    if (!event.isClicked) {
      emit(state.copyWith(isClicked: event.isClicked));
      return;
    }

    colorBloc.state.selectedColorMap
        .sort((a, b) => (a['colorId']).compareTo(b['colorId']));
    sizeBloc.state.selectedSizeMap!
        .sort((a, b) => (a['sizeId']).compareTo(b['sizeId']));

    for (var color in colorBloc.state.selectedColorMap) {
      for (var size in sizeBloc.state.selectedSizeMap!) {
        pricePerOptionList.add(
          {
            'color': color['color'],
            'size': size['size'],
            'price_difference': 0
          },
        );
      }
    }

    for (var value in state.pricePerOptionList) {
      for (var value2 in pricePerOptionList) {
        if (value['color'] == value2['color'] &&
            value['size'] == value2['size']) {
          value2['price_difference'] = value['price_difference'];
        }
      }
    }

    emit(state.copyWith(
        pricePerOptionList: pricePerOptionList, isClicked: event.isClicked));
  }

  void addPrice(
      ClickPlusPriceButtonEvent event, Emitter<PricePerOptionState> emit) {
    List<Map<String, dynamic>> copy = [];

    for (var value in state.pricePerOptionList) {
      copy.add(Map.from(value));
    }

    copy[event.index]['price_difference'] += 500;
    emit(state.copyWith(pricePerOptionList: copy));
  }

  void substractPrice(
      ClickMinusPriceButtonEvent event, Emitter<PricePerOptionState> emit) {
    List<Map<String, dynamic>> copy = [];
    for (var value in state.pricePerOptionList) {
      copy.add(Map.from(value));
    }
    copy[event.index]['price_difference'] -= 500;
    emit(state.copyWith(pricePerOptionList: copy));
  }

  @override
  Future<void> close() {
    colorSubScription.cancel();
    sizeSubScription.cancel();
    return super.close();
  }
}
