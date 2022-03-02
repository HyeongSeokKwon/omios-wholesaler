part of 'color_bloc.dart';

class ColorState extends Equatable {
  List<String> selectedColors;
  ColorState({
    required this.selectedColors,
  });

  factory ColorState.initial() {
    return ColorState(selectedColors: []);
  }

  @override
  List<Object> get props => [selectedColors];

  ColorState copyWith({
    List<String>? selectedColors,
  }) {
    return ColorState(
      selectedColors: selectedColors ?? this.selectedColors,
    );
  }
}
