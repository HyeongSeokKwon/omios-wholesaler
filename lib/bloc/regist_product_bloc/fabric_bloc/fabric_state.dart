part of 'fabric_bloc.dart';

class FabricState extends Equatable {
  List<Map> selectedFabric;
  List? fabricList;
  List<bool> isClicked;
  List<TextEditingController>? textController;
  FabricState({
    required this.selectedFabric,
    this.fabricList,
    required this.isClicked,
    this.textController,
  });

  factory FabricState.initial() {
    List fabricsList = [
      "면",
      "폴리에스테르",
      "나일론",
      "레이온",
      "울",
      "아크릴",
      "린넨",
      "스판",
      "폴리우레탄",
      "가죽",
      "캐시미어",
      "모달"
    ];

    return FabricState(
      selectedFabric: [],
      fabricList: fabricsList,
      isClicked: List.filled(fabricsList.length, false, growable: true),
      textController: List.filled(fabricsList.length, TextEditingController()),
    );
  }

  @override
  List<Object?> get props => [selectedFabric, fabricList, isClicked];

  FabricState copyWith({
    List<Map>? selectedFabric,
    List? fabricList,
    List<bool>? isClicked,
  }) {
    return FabricState(
      selectedFabric: selectedFabric ?? this.selectedFabric,
      fabricList: fabricList ?? this.fabricList,
      isClicked: isClicked ?? this.isClicked,
    );
  }
}