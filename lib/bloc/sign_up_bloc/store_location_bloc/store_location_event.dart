part of 'store_location_bloc.dart';

@immutable
abstract class StoreLocationEvent {}

class ClickBuildingListButtonEvent extends StoreLocationEvent {}

class SelectBuildingEvent extends StoreLocationEvent {
  final int selectIndex;

  SelectBuildingEvent(this.selectIndex);
}

class ClickFloorListButtonEvent extends StoreLocationEvent {}

class SelectFloorEvent extends StoreLocationEvent {
  final int selectIndex;

  SelectFloorEvent(this.selectIndex);
}

class ClickRoomNumberButtonEvent extends StoreLocationEvent {}

class InputRoomEvent extends StoreLocationEvent {
  final String roomInfo;
  InputRoomEvent(this.roomInfo);
}
