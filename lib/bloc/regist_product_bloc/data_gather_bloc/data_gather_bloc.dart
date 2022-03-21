import 'package:deepy_wholesaler/repository/regist_repository.dart';
import 'package:equatable/equatable.dart';

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

  final RegistRepository _registRepository = RegistRepository();
  Map<String, dynamic> registData = {};

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
  }) : super(DataGatherState.initial()) {
    on<ClickRegistButtonEvent>(manufactureData);
  }

  Future<void> manufactureData(
      ClickRegistButtonEvent event, Emitter<DataGatherState> emit) async {
    print("데이터 조합");
    if (categoryBloc.state.selectedSubCategory.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '세부 카테고리를 선택해주세요'));
      emit(state.copyWith(fetchState: FetchState.initial));
      return;
    }
    registData['sub_category'] = categoryBloc.state.selectedSubCategory['id'];

    if (nameBloc.state.name.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '상품명을 입력해주세요'));
      emit(state.copyWith(fetchState: FetchState.initial));
      return;
    }
    registData['name'] = nameBloc.state.name;

    if (priceBloc.state.price.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '가격을 입력해주세요'));
      emit(state.copyWith(fetchState: FetchState.initial));
      return;
    }
    registData['price'] = int.parse(priceBloc.state.price);

    if (colorBloc.state.selectedColorList.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '색상정보를 선택해주세요'));
      emit(state.copyWith(fetchState: FetchState.initial));
      return;
    }
    for (var value in colorBloc.state.selectedColorMap) {
      if (colorBloc.state.errorMessage.isNotEmpty) {
        emit(state.copyWith(
            isAllVerified: false,
            fetchState: FetchState.failure,
            error: colorBloc.state.errorMessage));
        emit(state.copyWith(fetchState: FetchState.initial));
        return;
      }
      if (value['images'] == null) {
        emit(state.copyWith(
            isAllVerified: false,
            fetchState: FetchState.failure,
            error: '색상별 이미지를 등록해주세요'));
        emit(state.copyWith(fetchState: FetchState.initial));
        return;
      }
    }
    await setColorInfo(); //색상에 대한 정보 병합

    if (photoBloc.state.basicPhoto.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '기본이미지를 등록해주세요'));
      emit(state.copyWith(fetchState: FetchState.initial));
      return;
    }
    await getNetworkBasicImagesPath(); //이미지 s3에 올리는 요청

    if (styleBloc.state.selectedStyle.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '스타일을 선택해주세요'));
      emit(state.copyWith(fetchState: FetchState.initial));
      return;
    }
    registData['style'] = styleBloc.state.selectedStyle['id'];

    if (ageGroupBloc.state.selectedAgeGroupId == -1) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '연령대를 선택해주세요'));
      emit(state.copyWith(fetchState: FetchState.initial));
      return;
    }
    registData['age'] = ageGroupBloc.state.selectedAgeGroupId;

    if (fabricBloc.state.selectedFabric.isEmpty) {
      emit(state.copyWith(
          isAllVerified: false,
          fetchState: FetchState.failure,
          error: '소재를 선택해주세요'));
      emit(state.copyWith(fetchState: FetchState.initial));
      return;
    }
    registData['materials'] = [];

    for (var element in fabricBloc.state.selectedFabric) {
      registData['materials'].add(
          {"material": element['name'], "mixing_rate": element['percent']});
    }

    if (laundryBloc.state.washingList.isNotEmpty) {
      if (laundryBloc.state.selectedLaundry.isEmpty) {
        emit(state.copyWith(
            isAllVerified: false,
            fetchState: FetchState.failure,
            error: '세탁정보를 선택해주세요'));
        emit(state.copyWith(fetchState: FetchState.initial));
        return;
      }
    }

    registData['laundry_informations'] = [];
    for (var element in laundryBloc.state.selectedLaundry) {
      registData['laundry_informations'].add(element['id']);
    }

    setAdditionalInfo(); //추가 정보 데이터 병합

    registData['tags'] = [1, 2, 3]; //임시로 tag data 넣어 놓았음.

    await _registRepository.registProduct(registData);
  }

  void setAdditionalInfo() {
    if (additionalInfoBloc.state.elasticityList == []) {
      registData['flexibility'] = null;
    } else {
      registData['thickness'] =
          additionalInfoBloc.state.selectedAdditionalInfo['thickness']!['id'];
    }

    if (additionalInfoBloc.state.liningList == []) {
      registData['lining'] = null;
    } else {
      registData['lining'] =
          additionalInfoBloc.state.selectedAdditionalInfo['lining']!['value'];
    }
    if (additionalInfoBloc.state.seeThroughList == []) {
      registData['see_through'] = null;
    } else {
      registData['see_through'] =
          additionalInfoBloc.state.selectedAdditionalInfo['see_through']!['id'];
    }
    if (additionalInfoBloc.state.thicknessList == []) {
      registData['thickness'] = null;
    } else {
      registData['flexibility'] =
          additionalInfoBloc.state.selectedAdditionalInfo['flexibility']!['id'];
    }
  }

  Future<void> getNetworkBasicImagesPath() async {
    List<dynamic> basicImagePathList = [];
    List<dynamic> networkImagesPath = [];
    registData['images'] = [];

    for (var photo in photoBloc.state.basicPhoto) {
      basicImagePathList.add(photo.image.file.path);
    }

    networkImagesPath = await _registRepository.registImage(basicImagePathList);
    int seq = 1;
    for (var photo in networkImagesPath) {
      //print(photoBloc.state.basicPhoto);
      registData['images'].add({
        'image_url': photo,
        'sequence': seq,
      });
      seq++;
    }
  }

  Future<void> setColorInfo() async {
    registData['colors'] = [];
    for (var infoByColor in colorBloc.state.selectedColorMap) {
      var networkImagePath = await _registRepository
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
          option['size'] = infoByColor['size']['size'];
          option['price_difference'] = infoByColor['price_difference'];
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
}
