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
  PhotoBloc photoBloc;
  FabricBloc fabricBloc;
  SizeBloc sizeBloc;
  LaundryBloc laundryBloc;
  PricePerOptionBloc pricePerOptionBloc;
  AdditionalInfoBloc additionalInfoBloc;
  AgeGroupBloc ageGroupBloc;
  ThemeBloc themeBloc;
  ManufacturecountryBloc manufacturecountryBloc;
  TagBloc tagBloc;
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
    required this.photoBloc,
    required this.sizeBloc,
    required this.laundryBloc,
    required this.pricePerOptionBloc,
    required this.additionalInfoBloc,
    required this.ageGroupBloc,
    required this.themeBloc,
    required this.manufacturecountryBloc,
    required this.tagBloc,
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
    laundryBloc.state.washingList = dynamicData['laundry_information'] ?? [];
    additionalInfoBloc.state.elasticityList = dynamicData['flexibility'] ?? [];
    additionalInfoBloc.state.thicknessList = dynamicData['thickness'] ?? [];
    additionalInfoBloc.state.seeThroughList = dynamicData['see_through'] ?? [];
    additionalInfoBloc.state.liningList = dynamicData['lining'] ?? [];
    print(additionalInfoBloc.state.thicknessList);
  }

  //registry-common api
  Future<void> fetchInitCommonInfo(
    FetchInitCommonInfoEvent event,
    Emitter<InititemState> emit,
  ) async {
    List<dynamic> categoryData;
    Map commonData;
    emit(state.copyWith(fetchState: FetchState.loading));

    try {
      categoryData = await registRepository.getCategoryInfo();

      commonData = await registRepository.getRegistryData();
      insertRegistryCommonData(categoryData, commonData); //항목데이터

      if (registMode == RegistMode.edit) {
        insertCommonData(initEditItemBloc!.state.data, categoryData);
        emit(state.copyWith(fetchState: FetchState.loading));
        Map dynamicData;
        dynamicData = await registRepository
            .getRegistryData(categoryBloc.state.selectedSubCategory['id'])
            .catchError((e) {
          emit(state.copyWith(fetchState: FetchState.failure));
        });

        insertRegistryDynamicData(dynamicData); //항목데이터
        insertDynamicData(initEditItemBloc!.state.data);
      }

      emit(state.copyWith(fetchState: FetchState.success));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(fetchState: FetchState.error, error: e.toString()));
    }
  }

  //registry-dynamic api
  Future<void> fetchInitDynamicInfo(
    FetchInitDynamicInfoEvent event,
    Emitter<InititemState> emit,
  ) async {
    emit(state.copyWith(fetchState: FetchState.loading));

    Map dynamicData;
    try {
      dynamicData = await registRepository
          .getRegistryData(categoryBloc.state.selectedSubCategory['id']);
      print("info");
      print(dynamicData);
      insertRegistryDynamicData(dynamicData);

      emit(state.copyWith(fetchState: FetchState.success));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(fetchState: FetchState.error, error: e.toString()));
    }
  }

  //update시 등록된 commondata initialize
  void insertCommonData(Map registedData, List categoryData) {
    //category 주입 완료
    for (var value in categoryData) {
      for (var subValue in value['sub_categories']) {
        if (subValue['id'] == registedData['sub_category']['id']) {
          categoryBloc.state.subCategoryInfo = value['sub_categories'];
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
      if (value['id'] == registedData['style']['id']) {
        styleBloc.state.selectedStyle = value;
      }
    }

    //age 주입 완료
    for (var value in ageGroupBloc.state.ageGroupList) {
      if (value['id'] == registedData['age']['id']) {
        ageGroupBloc.state.selectedAgeGroupId = value['id'];
      }
    }

    //theme 주입 완료
    themeBloc.state.selectedTheme = registedData['theme']['id'] ?? 0;

    //제조국 주입 완료
    manufacturecountryBloc.state.selectedCountry =
        registedData['manufacturing_country'];
    //소재 주입 완료

    for (var value in registedData['materials']) {
      bool isCustomed = true;
      fabricBloc.state.selectedFabric.add({
        'name': value['material'],
        'id': value['id'],
        'percent': value['mixing_rate']
      });

      for (var subValue in fabricBloc.state.fabricList) {
        if (subValue['name'] == value['material']) {
          isCustomed = false;
          int index = fabricBloc.state.fabricList.indexOf(subValue);
          fabricBloc.state.isClicked[index] = true;
          fabricBloc.state.textController[index].text =
              value['mixing_rate'].toString();
        }
      }
      if (isCustomed) {
        fabricBloc.state.textController
            .add(TextEditingController(text: value['mixing_rate'].toString()));
        fabricBloc.state.isClicked.add(true);
        fabricBloc.state.fabricList
            .add({'name': value['material'], 'id': value['id']});
      }
    }

    for (var value in registedData['tags']) {
      tagBloc.state.selectedTags.add(value);
    }

    //색깔 주입
    for (var value in registedData['colors']) {
      for (var subValue in colorBloc.state.colorList) {
        if (value['on_sale'] == true && subValue['id'] == value['color']) {
          colorBloc.state.selectedColorMap.add({
            'id': value['id'],
            'color': subValue['name'],
            'colorId': subValue['id'],
            'customedName': value['display_color_name'],
            'images': Image.network(value['image_url']),
          });
          colorBloc.state.selectedColorList.add(subValue['name']);
        }
      }
    }

    for (var value in registedData['images']) {
      photoBloc.state.basicPhoto
          .add({'image': Image.network(value['image_url']), 'id': value['id']});
    }
  }

  //update 시 등록된 dynamicdata initialize
  void insertDynamicData(Map registedData) {
    Set<String> size = {};

    for (var value in registedData['colors']) {
      for (var subValue in value['options']) {
        if (subValue['on_sale']) {
          size.add(subValue['size']);
        }
      }
    }

    sizeBloc.state.selectedSize = size.toList();
    for (var sizeValue in sizeBloc.state.selectedSize) {
      bool isCustomed = true;
      for (var subSizeValue in sizeBloc.state.sizeList) {
        if (sizeValue == subSizeValue['name']) {
          isCustomed = false;
          break;
        }
      }
      if (isCustomed) {
        sizeBloc.state.sizeList.add({'id': 0, 'name': sizeValue});
      }
    }
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
        if (value['on_sale'] == true &&
            subValue['customedName'] == value['display_color_name']) {
          colorInfo = subValue;
        }
      }

      for (var option in value['options']) {
        for (var sizeValue in sizeBloc.state.selectedSizeMap) {
          if (sizeValue['name'] == option['size'] &&
              option['on_sale'] == true) {
            sizeInfo = sizeValue;
          }
        }
        if (colorInfo.isNotEmpty &&
            sizeInfo.isNotEmpty &&
            option['on_sale'] == true) {
          pricePerOptionBloc.state.pricePerOptionList.add({
            'id': option['id'],
            'color': colorInfo,
            'size': sizeInfo,
            'inventory': 0,
          });

          pricePerOptionBloc.state.inventoryControllerList
              .add(TextEditingController(text: 0.toString()));
        }
      }
    }

    for (var value in laundryBloc.state.washingList) {
      for (var subValue in registedData['laundry_informations']) {
        if (subValue['id'] == value['id']) {
          laundryBloc.state.selectedLaundry.add(value);
        }
      }
    }

    if (additionalInfoBloc.state.thicknessList!.isNotEmpty) {
      additionalInfoBloc.state.selectedAdditionalInfo.addAll({
        'thickness': additionalInfoBloc
            .state.thicknessList![registedData['thickness']['id'] - 1],
        'see_through': additionalInfoBloc
            .state.seeThroughList![registedData['see_through']['id'] - 1],
        'flexibility': additionalInfoBloc
            .state.elasticityList![registedData['flexibility']['id'] - 1],
        'lining': registedData['lining'],
      });
    }
  }
}
