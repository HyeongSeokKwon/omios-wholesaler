import 'dart:async';

import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/repository/regist_repository.dart';
import 'package:equatable/equatable.dart';

part 'inititem_event.dart';
part 'inititem_state.dart';

class InititemBloc extends Bloc<InititemEvent, InititemState> {
  CategoryBloc categoryBloc;
  ColorBloc colorBloc;
  StyleBloc styleBloc;
  FabricBloc fabricBloc;
  SizeBloc sizeBloc;
  LaundryBloc laundryBloc;
  AdditionalInfoBloc additionalInfoBloc;

  final RegistRepository registRepository = RegistRepository();

  late final StreamSubscription categorySubScription;

  InititemBloc({
    required this.categoryBloc,
    required this.colorBloc,
    required this.styleBloc,
    required this.fabricBloc,
    required this.sizeBloc,
    required this.laundryBloc,
    required this.additionalInfoBloc,
  }) : super(InititemState.initial()) {
    categoryBloc.stream.listen((CategoryState state) {
      if (state.selectedSubCategory.isNotEmpty) {
        add(FetchInitDynamicInfoEvent());
      }
    });
    on<FetchInitCommonInfoEvent>(fetchInitCommonInfo);
    on<FetchInitDynamicInfoEvent>(fetchInitDynamicInfo);
  }

  Future<void> fetchInitCommonInfo(
    FetchInitCommonInfoEvent event,
    Emitter<InititemState> emit,
  ) async {
    List<dynamic> categoryData;
    Map commonData;

    categoryData = await registRepository.getCategoryInfo().catchError((e) {
      emit(state.copyWith(fetchState: FetchState.failure));
    });
    commonData = await registRepository.getRegistryCommon().catchError((e) {
      emit(state.copyWith(fetchState: FetchState.failure));
    });

    categoryBloc.state.categoryInfo = categoryData;
    colorBloc.state.colorList = commonData['color'];
    fabricBloc.state.fabricList = commonData['material'];
    styleBloc.state.styleList = commonData['style'];

    emit(state.copyWith(fetchState: FetchState.success));
  }

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

    sizeBloc.state.sizeList = dynamicData['size'] ?? [];

    laundryBloc.state.washingList = dynamicData['laundry_inforamtion'] ?? [];
    additionalInfoBloc.state.elasticityList = dynamicData['flexibility'] ?? [];
    additionalInfoBloc.state.thicknessList = dynamicData['thickness'] ?? [];
    additionalInfoBloc.state.seeThroughList = dynamicData['see_through'] ?? [];
    additionalInfoBloc.state.liningList = dynamicData['lining'] ?? [];
    emit(state.copyWith(fetchState: FetchState.success));
  }
}
