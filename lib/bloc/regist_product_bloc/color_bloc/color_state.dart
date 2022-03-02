part of 'color_bloc.dart';

class ColorState extends Equatable {
  List<Map> selectedColorMap;
  List<String> selectedColorList;
  ColorState({
    required this.selectedColorMap,
    required this.selectedColorList,
  });

  factory ColorState.initial() {
    return ColorState(selectedColorMap: [], selectedColorList: []);
  }

  @override
  List<Object> get props => [selectedColorMap, selectedColorList];

  ColorState copyWith({
    List<Map>? selectedColorMap,
    List<String>? selectedColorList,
  }) {
    return ColorState(
      selectedColorMap: selectedColorMap ?? this.selectedColorMap,
      selectedColorList: selectedColorList ?? this.selectedColorList,
    );
  }
}
