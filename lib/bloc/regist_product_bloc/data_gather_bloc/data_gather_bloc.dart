import 'dart:async';

import 'package:deepy_wholesaler/repository/regist_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../bloc.dart';

part 'data_gather_event.dart';
part 'data_gather_state.dart';

class DataGatherBloc extends Bloc<DataGatherEvent, DataGatherState> {
  NameBloc nameBloc;
  CategoryBloc categoryBloc;
  PriceBloc priceBloc;
  ColorBloc colorBloc;
  PricePerOptionBloc pricePerOptionBloc;
  StyleBloc styleBloc;
  PhotoBloc photoBloc;
  FabricBloc fabricBloc;
  SizeBloc sizeBloc;
  LaundryBloc laundryBloc;
  AdditionalInfoBloc additionalInfoBloc;
  AgeGroupBloc ageGroupBloc;
  TagBloc tagBloc;
  ThemeBloc themeBloc;
  ManufacturecountryBloc manufacturecountryBloc;
  InitEditItemBloc? initEditItemBloc;

  final RegistRepository _registRepository = RegistRepository();
  Map<String, dynamic> registData = {};
  Map<String, dynamic> beforeData = {};
  late final StreamSubscription initItemSubScription;

  DataGatherBloc({
    required this.nameBloc,
    required this.categoryBloc,
    required this.priceBloc,
    required this.colorBloc,
    required this.photoBloc,
    required this.pricePerOptionBloc,
    required this.styleBloc,
    required this.fabricBloc,
    required this.sizeBloc,
    required this.laundryBloc,
    required this.additionalInfoBloc,
    required this.ageGroupBloc,
    required this.tagBloc,
    required this.themeBloc,
    required this.manufacturecountryBloc,
    this.initEditItemBloc,
  }) : super(DataGatherState.initial()) {
    on<CombineDataEvent>(combineData);
    on<RegistEvent>(registingData);
  }

  Future<void> registingData(
      RegistEvent event, Emitter<DataGatherState> emit) async {
    emit(state.copyWith(registState: FetchState.initial));
    if (event.registMode == RegistMode.regist) {
      print("regist");
      print(registData);
      await _registRepository.registProduct(registData);
    }
    //기존 상품 정보 변경시
    if (event.registMode == RegistMode.edit) {
      var body = {};
      print(body);
      body = compareUpdatedData();
      await _registRepository.updateProduct(
          body, initEditItemBloc!.state.data['id']);
    }
    emit(state.copyWith(registState: FetchState.success));
    return;
  }

  Future<void> combineData(
      CombineDataEvent event, Emitter<DataGatherState> emit) async {
    emit(state.copyWith(gatherState: GatherState.progress));

    if (categoryBloc.state.selectedSubCategory.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '세부 카테고리를 선택해주세요'));
      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }
    registData['sub_category'] = categoryBloc.state.selectedSubCategory['id'];

    if (nameBloc.state.name.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '상품명을 입력해주세요'));
      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }
    registData['name'] = nameBloc.state.name;

    if (priceBloc.state.price.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '가격을 입력해주세요'));
      emit(state.copyWith(
          fetchState: FetchState.failure, gatherState: GatherState.failure));
      return;
    }
    registData['price'] = int.parse(
      priceBloc.state.price,
    );

    if (colorBloc.state.selectedColorList.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '색상정보를 선택해주세요'));
      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }
    for (var value in colorBloc.state.selectedColorMap) {
      if (colorBloc.state.errorMessage.isNotEmpty) {
        emit(state.copyWith(
            isAllVerified: false,
            fetchState: FetchState.failure,
            error: colorBloc.state.errorMessage));
        emit(state.copyWith(
            fetchState: FetchState.initial, gatherState: GatherState.failure));
        return;
      }
      if (value['images'] == null) {
        emit(state.copyWith(
            isAllVerified: false,
            fetchState: FetchState.failure,
            error: '색상별 이미지를 등록해주세요'));
        emit(state.copyWith(
            fetchState: FetchState.initial, gatherState: GatherState.failure));
        return;
      }
    }
    await setColorInfo(); //색상에 대한 정보 병합

    if (photoBloc.state.basicPhoto.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '기본이미지를 등록해주세요'));
      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }
    await getNetworkBasicImagesPath(event.registMode); //이미지 s3에 올리는 요청

    if (sizeBloc.state.selectedSize.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '사이즈를 선택해주세요'));
      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }

    if (styleBloc.state.selectedStyle.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '스타일을 선택해주세요'));
      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }
    registData['style'] = styleBloc.state.selectedStyle['id'];

    if (ageGroupBloc.state.selectedAgeGroupId == -1) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '연령대를 선택해주세요'));
      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }
    registData['age'] = ageGroupBloc.state.selectedAgeGroupId;

    if (fabricBloc.state.selectedFabric.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '소재를 선택해주세요'));
      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }
    registData['materials'] = [];

    for (var element in fabricBloc.state.selectedFabric) {
      Map addedData = {
        "material": element['name'],
        "mixing_rate": element['percent']
      };
      if (event.registMode == RegistMode.edit) {
        if (element.containsKey('id')) {
          addedData['id'] = element['id'];
        }
      }

      registData['materials'].add(addedData);
    }

    if (laundryBloc.state.washingList.isNotEmpty) {
      if (laundryBloc.state.selectedLaundry.isEmpty) {
        emit(state.copyWith(
            isAllVerified: false,
            fetchState: FetchState.failure,
            error: '세탁정보를 선택해주세요'));
        emit(state.copyWith(
            fetchState: FetchState.initial, gatherState: GatherState.failure));
        return;
      }
    }

    registData['laundry_informations'] = [];
    for (var element in laundryBloc.state.selectedLaundry) {
      registData['laundry_informations'].add(element['id']);
    }

    if (additionalInfoBloc.state.elasticityList!.isNotEmpty &&
        additionalInfoBloc.state.liningList!.isNotEmpty &&
        additionalInfoBloc.state.seeThroughList!.isNotEmpty &&
        additionalInfoBloc.state.thicknessList!.isNotEmpty) {
      if (!additionalInfoBloc.state.selectedAdditionalInfo
              .containsKey('thickness') ||
          !additionalInfoBloc.state.selectedAdditionalInfo
              .containsKey('lining') ||
          !additionalInfoBloc.state.selectedAdditionalInfo
              .containsKey('see_through') ||
          !additionalInfoBloc.state.selectedAdditionalInfo
              .containsKey('flexibility')) {
        emit(state.copyWith(
            isAllVerified: false,
            fetchState: FetchState.failure,
            error: '추가정보를 선택해주세요'));
        emit(state.copyWith(
            fetchState: FetchState.initial, gatherState: GatherState.failure));
        return;
      }
    }

    setAdditionalInfo(); //추가 정보 데이터 병합

    if (manufacturecountryBloc.state.selectedCountry.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: "제조국을 선택해주세요"));

      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }
    registData['manufacturing_country'] =
        manufacturecountryBloc.state.selectedCountry;

    if (tagBloc.state.selectedTags.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: "태그를 선택해주세요"));

      emit(state.copyWith(
          fetchState: FetchState.initial, gatherState: GatherState.failure));
      return;
    }
    registData['tags'] = [];
    for (var value in tagBloc.state.selectedTags) {
      registData['tags'].add(value['id']);
    }

    if (themeBloc.state.selectedTheme == 0) {
      registData['theme'] = null;
    } else {
      registData['theme'] = themeBloc.state.selectedTheme;
    }
    if (event.registMode == RegistMode.edit && beforeData.isEmpty) {
      beforeData.addAll(registData);
      registData = {};
    }

    if (event.callState == 'init') {
      emit(state.copyWith(gatherState: GatherState.progress));
    } else {
      emit(state.copyWith(gatherState: GatherState.success));
    }
    emit(state.copyWith(gatherState: GatherState.initial));
  }

  void setAdditionalInfo() {
    print(additionalInfoBloc.state.selectedAdditionalInfo);
    if (additionalInfoBloc.state.elasticityList!.isEmpty) {
      registData['flexibility'] = null;
    } else {
      registData['flexibility'] =
          additionalInfoBloc.state.selectedAdditionalInfo['flexibility']['id'];
    }

    if (additionalInfoBloc.state.liningList!.isEmpty) {
      registData['lining'] = null;
    } else {
      registData['lining'] =
          additionalInfoBloc.state.selectedAdditionalInfo['lining'];
    }

    if (additionalInfoBloc.state.seeThroughList!.isEmpty) {
      registData['see_through'] = null;
    } else {
      registData['see_through'] =
          additionalInfoBloc.state.selectedAdditionalInfo['see_through']['id'];
    }

    if (additionalInfoBloc.state.thicknessList!.isEmpty) {
      registData['thickness'] = null;
    } else {
      registData['thickness'] =
          additionalInfoBloc.state.selectedAdditionalInfo['thickness']['id'];
    }
  }

  Future<void> getNetworkBasicImagesPath(RegistMode registMode) async {
    List<dynamic> basicImagePathList = [];
    List<dynamic> networkImagesPath = [];
    List<dynamic> notTransformedPath = [];

    List<int> notTransformedPathIndex = [];
    registData['images'] = [];
    if (registMode == RegistMode.regist) {
      for (var photo in photoBloc.state.basicPhoto) {
        notTransformedPath.add(photo['image'].image.file.path);
      }
      networkImagesPath =
          await _registRepository.registImage(notTransformedPath);

      int seq = 1;
      for (var photo in networkImagesPath) {
        registData['images'].add({
          'image_url': photo,
          'sequence': seq,
        });
        seq++;
      }
    } else {
      for (Map photo in photoBloc.state.basicPhoto) {
        if (photo['image'].image is NetworkImage) {
          //기존 이미지
          basicImagePathList
              .add({'image': photo['image'].image.url, 'id': photo['id']});
        } else {
          //신규 추가된 이미지
          notTransformedPath.add(photo['image'].image.file.path);
          notTransformedPathIndex
              .add(photoBloc.state.basicPhoto.indexOf(photo));
        }
      }
      networkImagesPath =
          await _registRepository.registImage(notTransformedPath);

      for (var photo in networkImagesPath) {
        basicImagePathList.insert(notTransformedPathIndex[0], {'image': photo});
        notTransformedPathIndex.removeAt(0);
      }

      int seq = 1;
      for (Map photo in basicImagePathList) {
        registData['images'].add({
          'image_url': photo['image'],
          'sequence': seq,
        });
        if (photo.containsKey('id')) {
          registData['images'][registData['images'].length - 1]['id'] =
              photo['id'];
        }
        seq++;
      }
    }
  } //

  Future<void> setColorInfo() async {
    registData['colors'] = [];
    for (var infoByColor in colorBloc.state.selectedColorMap) {
      var networkImagePath = infoByColor['images'].image is NetworkImage
          ? [infoByColor['images'].image.url]
          : await _registRepository
              .registImage([infoByColor['images'].image.file.path]);

      registData['colors'].add({
        'color': infoByColor['colorId'],
        'display_color_name': infoByColor['customedName'],
        'options': [],
        'image_url': networkImagePath[0],
      });
    }

    Map options = {};
    for (var color in colorBloc.state.selectedColorMap) {
      options[color['customedName']] = [];
      for (var infoByColor in pricePerOptionBloc.state.pricePerOptionList) {
        Map option = {};

        if (color['customedName'] == infoByColor['color']['customedName']) {
          option['size'] = infoByColor['size']['name'];
          option['inventory'] = infoByColor['inventory'];
          options[color['customedName']].add(option);
        }
      }
      for (var value in registData['colors']) {
        if (color['customedName'] == value['display_color_name']) {
          value['options'].addAll(options[color['customedName']]);
          break;
        }
      }
    }
  }

  Map compareUpdatedData() {
    Map bodyData = {};

    //post man 순서로 작업
    if (registData['name'] != beforeData['name']) {
      bodyData['name'] = registData['name'];
    }

    if (registData['price'] != beforeData['price']) {
      bodyData['price'] = registData['price'];
    }

    if (registData['sub_category'] != beforeData['sub_category']) {
      bodyData['sub_category'] = registData['sub_category'];
    }

    if (registData['style'] != beforeData['style']) {
      bodyData['style'] = registData['style'];
    }

    if (registData['age'] != beforeData['age']) {
      bodyData['age'] = registData['age'];
    }

    if (!listEquals(registData['tags'], beforeData['tags'])) {
      bodyData['tags'] = registData['tags'];
    }

    if (!listEquals(registData['laundry_informations'],
        beforeData['laundry_informations'])) {
      bodyData['laundry_informations'] = registData['laundry_informations'];
    }

    if (registData['thickness'] != beforeData['thickness']) {
      bodyData['thickness'] = registData['thickness'];
    }

    if (registData['lining'] != beforeData['lining']) {
      bodyData['lining'] = registData['lining'];
    }

    if (registData['see_through'] != beforeData['see_through']) {
      bodyData['see_through'] = registData['see_through'];
    }

    if (registData['flexibility'] != beforeData['flexibility']) {
      bodyData['flexibility'] = registData['flexibility'];
    }

    if (registData['manufacturing_country'] !=
        beforeData['manufacturing_country']) {
      bodyData['manufacturing_country'] = registData['manufacturing_country'];
    }
    if (registData['theme'] != beforeData['theme']) {
      bodyData['theme'] = registData['theme'];
    }
    bodyData['materials'] = [];
    //신규 소재 추가 or 기존 소재 변경시
    for (Map value in registData['materials']) {
      bodyData['materials'].add(value);
    }

    //기존 소재 삭제시
    for (Map value in initEditItemBloc!.state.data['materials']) {
      bool isDeleted = true;
      for (Map registValue in registData['materials']) {
        if (registValue.containsKey('id')) {
          if (value['id'] == registValue['id']) {
            isDeleted = false;
          }
        }
      }

      if (isDeleted) {
        bodyData['materials'].add({'id': value['id']});
      }
    }
    bodyData['images'] = [];
    for (Map value in registData['images']) {
      bodyData['images'].add(value);
    }

    for (Map value in initEditItemBloc!.state.data['images']) {
      bool isDeleted = true;
      for (Map registValue in registData['images']) {
        if (registValue.containsKey('id')) {
          if (value['id'] == registValue['id']) {
            isDeleted = false;
          }
        }
      }

      if (isDeleted) {
        bodyData['images'].add({'id': value['id']});
      }
    }

    //colorData 삭제
    for (Map registedValue in initEditItemBloc!.state.data['colors']) {
      bool isDeleted = true;
      for (Map willRegistValue in registData['colors']) {
        if (registedValue['display_color_name'] ==
                willRegistValue['display_color_name'] &&
            registedValue['color'] == willRegistValue['color']) {
          isDeleted = false;
          break;
        }
      }
      if (isDeleted == true && registedValue['on_sale'] == true) {
        registData['colors'].add({'id': registedValue['id']});
        print("deleted");
      }
    }

    print("기존 등록된 데이터");
    print(initEditItemBloc!.state.data['colors']);
    print("===================================");
    print("향후 업데이트 될 데이터");
    print(registData['colors']);
    print("===================================");

    List<int> notChangedColorIndex = [];
    for (Map willRegistValue in registData['colors']) {
      for (Map registedValue in initEditItemBloc!.state.data['colors']) {
        if (willRegistValue['color'] ==
                registedValue['color'] && // 일단 color 정보는 바뀌지 않았을때
            willRegistValue['display_color_name'] ==
                registedValue['display_color_name']) {
          if (registedValue['image_url'] == willRegistValue['image_url']) {
            willRegistValue.remove('image_url');
          }

          for (Map registedOptionValue in registedValue['options']) {
            bool isDeleted = true;
            for (Map willRegistOptionValue in willRegistValue['options']) {
              if (registedOptionValue['size'] ==
                  willRegistOptionValue['size']) {
                isDeleted = false;
                break;
              }
            }
            if (isDeleted && registedOptionValue['on_sale'] == true) {
              print("option is deleted");
              willRegistValue['options'].add({'id': registedOptionValue['id']});
            }
          }
          List<int> notChangedOptionIndex = [];
          for (Map willRegistOptionValue in willRegistValue['options']) {
            for (Map registedOptionValue in registedValue['options']) {
              if (willRegistOptionValue['size'] ==
                      registedOptionValue['size'] &&
                  registedOptionValue['on_sale']) {
                willRegistOptionValue['id'] = registedOptionValue['id'];
                willRegistOptionValue.remove('size');

                if (willRegistOptionValue['price_difference'] ==
                    registedOptionValue['price_difference']) {
                  willRegistOptionValue.remove('price_difference');
                  willRegistOptionValue['isChanged'] = false;
                }
              }
              willRegistOptionValue.remove('inventory');
            }
            if (willRegistOptionValue.containsKey('isChanged') &&
                willRegistOptionValue['isChanged'] == false) {
              //위의 과정에서 변경되지 않은 부분은 모두 body에서 삭제 진행했음, 위 과정을 거치고 id만 남았으면 데이터가 바뀌지 않았다고 볼수 있음.
              notChangedOptionIndex.add(
                  willRegistValue['options'].indexOf(willRegistOptionValue));
            }
          }

          for (int index in notChangedOptionIndex.reversed) {
            willRegistValue['options']
                .removeAt(index); // 변경되지 않은 옵션은 넘길 필요 없으니까 body에서 삭제
          }

          if (willRegistValue['options'].isEmpty) {
            //변경되지 않은 옵션을 삭제후, 만약 option의 value가 비어있다면 key 값인 option 삭제
            willRegistValue.remove('options');
          }

          willRegistValue.remove('color');
          willRegistValue.remove('display_color_name');
          willRegistValue['id'] = registedValue['id']; // Id를 그대로 가져감
          willRegistValue['isChanged'] = false;
          notChangedColorIndex
              .add(registData['colors'].indexOf(willRegistValue));
        }
      }
    }

    for (int index in notChangedColorIndex.reversed) {
      if (registData['colors'][index].containsKey('id') &&
          registData['colors'][index].containsKey('isChanged') &&
          registData['colors'][index].length == 2) {
        registData['colors'].removeAt(index);
      }
    }

    for (Map value in registData['colors']) {
      if (value.containsKey('isChanged')) {
        value.remove('isChanged');
        continue;
      }
    }

    if (registData['colors'].isNotEmpty) {
      bodyData['colors'] = registData['colors'];
    }

    print("=====patch시 body에 담길 Data====");
    print(bodyData);
    return bodyData;
  }
}
