import 'dart:async';

import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/repository/regist_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'inititem_event.dart';
part 'inititem_state.dart';

class InititemBloc extends Bloc<InititemEvent, InititemState> {
  CategoryBloc categoryBloc;
  NameBloc nameBloc;
  PriceBloc priceBloc;
  ColorBloc colorBloc;
  StyleBloc styleBloc;
  FabricBloc fabricBloc;
  SizeBloc sizeBloc;
  LaundryBloc laundryBloc;
  PricePerOptionBloc pricePerOptionBloc;
  AdditionalInfoBloc additionalInfoBloc;
  AgeGroupBloc ageGroupBloc;
  ThemeBloc themeBloc;
  ManufacturecountryBloc manufacturecountryBloc;
  RegistMode registMode;
  InitEditItemBloc? initEditItemBloc;

  final RegistRepository registRepository = RegistRepository();

  late final StreamSubscription categorySubScription;

  InititemBloc({
    required this.nameBloc,
    required this.priceBloc,
    required this.categoryBloc,
    required this.colorBloc,
    required this.styleBloc,
    required this.fabricBloc,
    required this.sizeBloc,
    required this.laundryBloc,
    required this.pricePerOptionBloc,
    required this.additionalInfoBloc,
    required this.ageGroupBloc,
    required this.themeBloc,
    required this.manufacturecountryBloc,
    required this.registMode,
    this.initEditItemBloc,
  }) : super(InititemState.initial()) {
    categoryBloc.stream.listen((CategoryState state) {
      if (state.selectedSubCategory.isNotEmpty) {
        add(FetchInitDynamicInfoEvent());
      }
    });
    on<FetchInitCommonInfoEvent>(fetchInitCommonInfo);
    on<FetchInitDynamicInfoEvent>(fetchInitDynamicInfo);
  }

  void insertRegistryCommonData(List<dynamic> categoryData, Map commonData) {
    categoryBloc.state.categoryInfo = categoryData;
    colorBloc.state.colorList = commonData['color'];

    fabricBloc.state.fabricList = commonData['material'];
    fabricBloc.state.isClicked =
        List.filled(commonData['material'].length, false, growable: true);

    fabricBloc.state.textController = List.generate(
      commonData['material'].length,
      (i) => TextEditingController(),
    );

    styleBloc.state.styleList = commonData['style'];
    ageGroupBloc.state.ageGroupList = commonData['age'];
    themeBloc.state.themeList = commonData['theme'];
    themeBloc.state.themeList.add({'id': 0, 'name': '없음'});
  }

  void insertRegistryDynamicData(Map dynamicData) {
    sizeBloc.state.sizeList = dynamicData['size'] ?? [];

    laundryBloc.state.washingList = dynamicData['laundry_inforamtion'] ?? [];

    additionalInfoBloc.state.elasticityList = dynamicData['flexibility'] ?? [];
    additionalInfoBloc.state.thicknessList = dynamicData['thickness'] ?? [];
    additionalInfoBloc.state.seeThroughList = dynamicData['see_through'] ?? [];
    additionalInfoBloc.state.liningList = dynamicData['lining'] ?? [];
  }

  //registry-common api
  Future<void> fetchInitCommonInfo(
    FetchInitCommonInfoEvent event,
    Emitter<InititemState> emit,
  ) async {
    List<dynamic> categoryData;
    Map commonData;
    emit(state.copyWith(fetchState: FetchState.loading));

    categoryData = await registRepository.getCategoryInfo().catchError((e) {
      emit(state.copyWith(fetchState: FetchState.failure));
    });

    commonData = await registRepository.getRegistryCommon().catchError((e) {
      emit(state.copyWith(fetchState: FetchState.failure));
    });

    insertRegistryCommonData(categoryData, commonData);

    if (registMode == RegistMode.edit) {
      insertCommonData(initEditItemBloc!.state.data, categoryData);
      emit(state.copyWith(fetchState: FetchState.loading));

      Map dynamicData;
      dynamicData = await registRepository
          .getRegistryDynamic(categoryBloc.state.selectedSubCategory['id'])
          .catchError((e) {
        emit(state.copyWith(fetchState: FetchState.failure));
      });

      insertRegistryDynamicData(dynamicData);
      insertDynamicData(initEditItemBloc!.state.data);
    }

    emit(state.copyWith(fetchState: FetchState.success));
  }

  //registry-dynamic api
  Future<void> fetchInitDynamicInfo(
    FetchInitDynamicInfoEvent event,
    Emitter<InititemState> emit,
  ) async {
    emit(state.copyWith(fetchState: FetchState.loading));

    Map dynamicData;
    dynamicData = await registRepository
        .getRegistryDynamic(categoryBloc.state.selectedSubCategory['id'])
        .catchError((e) {
      emit(state.copyWith(fetchState: FetchState.failure));
    });

    insertRegistryDynamicData(dynamicData);

    emit(state.copyWith(fetchState: FetchState.success));
  }

  //update시 등록된 commondata initialize
  void insertCommonData(Map registedData, List categoryData) {
    //category 주입 완료
    for (var value in categoryData) {
      for (var subValue in value['sub_category']) {
        if (subValue['id'] == registedData['sub_category']) {
          categoryBloc.state.selectedMainCategory = value;
          categoryBloc.state.selectedSubCategory = subValue;
        }
      }
    }

    //name 주입 완료
    nameBloc.state.name = registedData['name'];
    nameBloc.state.textEditingController.text = registedData['name'];

    //price 주입 완료
    priceBloc.state.price = registedData['price'].toString();
    priceBloc.state.textEditingController.text =
        registedData['price'].toString();

    //style 주입 완료
    for (var value in styleBloc.state.styleList) {
      if (value['id'] == registedData['style']) {
        styleBloc.state.selectedStyle = value;
      }
    }

    //age 주입 완료
    for (var value in ageGroupBloc.state.ageGroupList) {
      if (value['id'] == registedData['age']) {
        ageGroupBloc.state.selectedAgeGroupId = value['id'];
      }
    }

    //theme 주입 완료
    themeBloc.state.selectedTheme = registedData['theme'] ?? 0;

    //제조국 주입 완료
    manufacturecountryBloc.state.selectedCountry =
        registedData['manufacturing_country'];
    //소재 주입 완료
    for (var value in registedData['materials']) {
      fabricBloc.state.selectedFabric.add({
        'name': value['material'],
        'fabricId': value['id'],
        'percent': value['mixing_rate']
      });
      for (var subValue in fabricBloc.state.fabricList) {
        if (subValue['name'] == value['material']) {
          int index = fabricBloc.state.fabricList.indexOf(subValue);
          fabricBloc.state.isClicked[index] = true;
          fabricBloc.state.textController[index].text =
              value['mixing_rate'].toString();
        }
      }
    }
    //색깔 주입
    for (var value in registedData['colors']) {
      for (var subValue in colorBloc.state.colorList) {
        if (subValue['id'] == value['color']) {
          colorBloc.state.selectedColorMap.add({
            'color': subValue['name'],
            'colorId': subValue['id'],
            'customedName': value['display_color_name'],
            'images': null,
          });
          colorBloc.state.selectedColorList.add(subValue['name']);
        }
      }
    }
  }

  //update 시 등록된 dynamicdata initialize
  void insertDynamicData(Map registedData) {
    Set<String> size = {};

    for (var value in registedData['colors']) {
      for (var subValue in value['options']) {
        size.add(subValue['size']);
      }
    }

    sizeBloc.state.selectedSize = size.toList();
    for (var value in sizeBloc.state.sizeList) {
      for (var subValue in sizeBloc.state.selectedSize) {
        if (subValue == value['name']) {
          sizeBloc.state.selectedSizeMap.add(value);
        }
      }
    }

    for (var value in registedData['colors']) {
      Map colorInfo = {};
      Map sizeInfo = {};
      for (var subValue in colorBloc.state.selectedColorMap) {
        if (subValue['customedName'] == value['display_color_name']) {
          colorInfo = subValue;
        }
      }

      for (var subValue in sizeBloc.state.selectedSizeMap) {
        if (subValue['size'] == value['options']['size']) {
          sizeInfo = subValue;
        }
      }

      pricePerOptionBloc.state.pricePerOptionList.add({
        'color': colorInfo,
        'size': sizeInfo,
        'price': int.parse(priceBloc.state.price),
        'price_difference': value['options']['price_difference'],
        'inventory': 0,
      });
    }

    for (var value in laundryBloc.state.washingList) {
      for (var subValue in registedData['laundry_informations']) {
        if (subValue == value['id']) {
          laundryBloc.state.selectedLaundry.add(value);
        }
      }
    }
    additionalInfoBloc.state.selectedAdditionalInfo.addAll({
      'thickness': additionalInfoBloc
          .state.thicknessList![registedData['thickness'] - 1],
      'see_through': additionalInfoBloc
          .state.seeThroughList![registedData['see_through'] - 1],
      'flexibility': additionalInfoBloc
          .state.elasticityList![registedData['flexibility'] - 1],
      'lining': registedData['lining'],
    });
  }
}
