part of 'size_bloc.dart';

class SizeState extends Equatable {
  final List<String> selectedSize;
  List<Map>? selectedSizeMap;
  SizeState({required this.selectedSize, this.selectedSizeMap});

  factory SizeState.initial() {
    return SizeState(selectedSize: [], selectedSizeMap: []);
  }

  @override
  List<Object?> get props => [selectedSize, selectedSizeMap];

  SizeState copyWith({
    List<String>? selectedSize,
    List<Map>? selectedSizeMap,
  }) {
    return SizeState(
      selectedSize: selectedSize ?? this.selectedSize,
      selectedSizeMap: selectedSizeMap ?? this.selectedSizeMap,
    );
  }
}
