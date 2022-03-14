part of 'size_bloc.dart';

class SizeState extends Equatable {
  List<String> selectedSize;
  List<Map>? selectedSizeMap;
  List<dynamic> sizeList;
  SizeState(
      {required this.selectedSize,
      this.selectedSizeMap,
      required this.sizeList});

  factory SizeState.initial() {
    return SizeState(selectedSize: [], selectedSizeMap: [], sizeList: []);
  }

  @override
  List<Object?> get props => [selectedSize, selectedSizeMap, sizeList];

  SizeState copyWith({
    List<String>? selectedSize,
    List<Map>? selectedSizeMap,
    List<dynamic>? sizeList,
  }) {
    return SizeState(
      selectedSize: selectedSize ?? this.selectedSize,
      selectedSizeMap: selectedSizeMap ?? this.selectedSizeMap,
      sizeList: sizeList ?? this.sizeList,
    );
  }
}
