part of 'fabric_bloc.dart';

class FabricState extends Equatable {
  List<Map> selectedFabric;
  List fabricList;
  List<bool> isClicked;
  List<TextEditingController> textController;
  int sum;
  FabricState({
    required this.selectedFabric,
    required this.fabricList,
    required this.isClicked,
    required this.textController,
    required this.sum,
  });

  factory FabricState.initial() {
    return FabricState(
      selectedFabric: const [],
      fabricList: const [],
      isClicked: const [],
      textController: const [],
      sum: 0,
    );
  }

  @override
  List<Object?> get props =>
      [selectedFabric, fabricList, isClicked, sum, textController];

  FabricState copyWith({
    List<Map>? selectedFabric,
    List? fabricList,
    List<bool>? isClicked,
    List<TextEditingController>? textController,
    int? sum,
  }) {
    return FabricState(
      selectedFabric: selectedFabric ?? this.selectedFabric,
      fabricList: fabricList ?? this.fabricList,
      textController: textController ?? this.textController,
      isClicked: isClicked ?? this.isClicked,
      sum: sum ?? this.sum,
    );
  }
}
