import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/repository/sign_up_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'store_location_event.dart';
part 'store_location_state.dart';

class StoreLocationBloc extends Bloc<StoreLocationEvent, StoreLocationState> {
  SignUpRepository signUpRepository = SignUpRepository();

  StoreLocationBloc() : super(StoreLocationState.initial()) {
    on<ClickBuildingListButtonEvent>(getBuildingList);
    on<SelectBuildingEvent>(selectBuilding);
    on<SelectFloorEvent>(selectFloor);
    on<InputRoomEvent>(inputRoom);
  }

  Future<void> getBuildingList(ClickBuildingListButtonEvent event,
      Emitter<StoreLocationState> emit) async {
    emit(state.copyWith(fetchState: FetchState.loading));
    List<dynamic> storeLocationInfo;
    List<dynamic> buildingInfo = [];

    try {
      storeLocationInfo = await signUpRepository.getBuildingInfos();
      for (Map value in storeLocationInfo) {
        buildingInfo.add(value['name']);
      }

      emit(state.copyWith(
          fetchState: FetchState.success,
          storeLocationInfo: storeLocationInfo,
          buildingInfo: buildingInfo));
    } catch (e) {
      emit(state.copyWith(fetchState: FetchState.error));
    }
  }

  void selectBuilding(
      SelectBuildingEvent event, Emitter<StoreLocationState> emit) {
    emit(state.copyWith(
        selectedBuilding: state.storeLocationInfo[event.selectIndex]['name'],
        selectedFloor: '',
        zipCode: state.storeLocationInfo[event.selectIndex]['zip_code'],
        baseAddress: state.storeLocationInfo[event.selectIndex]['base_address'],
        floorInfo: state.storeLocationInfo[event.selectIndex]['floors'],
        isLocationDataNotEmpty: checkStoreLocationData()));
    emit(state.copyWith(isLocationDataNotEmpty: checkStoreLocationData()));
  }

  void selectFloor(SelectFloorEvent event, Emitter<StoreLocationState> emit) {
    emit(state.copyWith(
        selectedFloor: state.floorInfo[event.selectIndex],
        isLocationDataNotEmpty: checkStoreLocationData()));
    emit(state.copyWith(isLocationDataNotEmpty: checkStoreLocationData()));
  }

  void inputRoom(InputRoomEvent event, Emitter<StoreLocationState> emit) {
    emit(state.copyWith(
      inputRoom: event.roomInfo,
    ));
    emit(state.copyWith(isLocationDataNotEmpty: checkStoreLocationData()));
  }

  bool checkStoreLocationData() {
    if (state.selectedBuilding.isNotEmpty &&
        state.selectedFloor.isNotEmpty &&
        state.inputRoom.isNotEmpty) {
      return true;
    }
    return false;
  }
}
