part of 'store_location_bloc.dart';

@immutable
class StoreLocationState extends Equatable {
  final List<dynamic> storeLocationInfo;
  final List<dynamic> buildingInfo;
  final List<dynamic> floorInfo;
  final String selectedBuilding;
  final String selectedFloor;
  final String inputRoom;
  final FetchState fetchState;
  final String zipCode;
  final String baseAddress;
  final bool isLocationDataNotEmpty;
  const StoreLocationState({
    required this.storeLocationInfo,
    required this.buildingInfo,
    required this.floorInfo,
    required this.selectedBuilding,
    required this.selectedFloor,
    required this.inputRoom,
    required this.fetchState,
    required this.zipCode,
    required this.baseAddress,
    required this.isLocationDataNotEmpty,
  });

  factory StoreLocationState.initial() {
    return const StoreLocationState(
      fetchState: FetchState.initial,
      storeLocationInfo: [],
      floorInfo: [],
      selectedBuilding: '',
      selectedFloor: '',
      inputRoom: '',
      buildingInfo: [],
      zipCode: '',
      baseAddress: '',
      isLocationDataNotEmpty: false,
    );
  }

  StoreLocationState copyWith({
    List<dynamic>? storeLocationInfo,
    List<dynamic>? buildingInfo,
    List<dynamic>? floorInfo,
    String? selectedBuilding,
    String? selectedFloor,
    String? inputRoom,
    FetchState? fetchState,
    String? zipCode,
    String? baseAddress,
    bool? isLocationDataNotEmpty,
  }) {
    return StoreLocationState(
      storeLocationInfo: storeLocationInfo ?? this.storeLocationInfo,
      buildingInfo: buildingInfo ?? this.buildingInfo,
      floorInfo: floorInfo ?? this.floorInfo,
      selectedBuilding: selectedBuilding ?? this.selectedBuilding,
      selectedFloor: selectedFloor ?? this.selectedFloor,
      inputRoom: inputRoom ?? this.inputRoom,
      fetchState: fetchState ?? this.fetchState,
      zipCode: zipCode ?? this.zipCode,
      baseAddress: baseAddress ?? this.baseAddress,
      isLocationDataNotEmpty:
          isLocationDataNotEmpty ?? this.isLocationDataNotEmpty,
    );
  }

  @override
  List<Object> get props {
    return [
      storeLocationInfo,
      buildingInfo,
      floorInfo,
      selectedBuilding,
      selectedFloor,
      inputRoom,
      fetchState,
      zipCode,
      baseAddress,
      isLocationDataNotEmpty,
    ];
  }
}
