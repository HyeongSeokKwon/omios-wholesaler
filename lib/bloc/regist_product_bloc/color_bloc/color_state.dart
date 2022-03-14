// ignore_for_file: must_be_immutable

part of 'color_bloc.dart';

class ColorState extends Equatable {
  List<Map<String, dynamic>> selectedColorMap;
  List<String> selectedColorList;
  List<dynamic> colorList;

  ColorState({
    required this.selectedColorMap,
    required this.selectedColorList,
    required this.colorList,
  });

  factory ColorState.initial() {
    return ColorState(
      selectedColorMap: [],
      selectedColorList: [],
      colorList: [],
    );
  }

  @override
  List<Object> get props => [selectedColorMap, selectedColorList];

  ColorState copyWith({
    List<Map<String, dynamic>>? selectedColorMap,
    List<String>? selectedColorList,
    List<dynamic>? colorList,
  }) {
    return ColorState(
      selectedColorMap: selectedColorMap ?? this.selectedColorMap,
      selectedColorList: selectedColorList ?? this.selectedColorList,
      colorList: colorList ?? this.colorList,
    );
  }
}
