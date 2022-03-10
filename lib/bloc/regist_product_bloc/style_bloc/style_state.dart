part of 'style_bloc.dart';

class StyleState extends Equatable {
  final String selectedStyle;
  List<dynamic> styleList;
  StyleState({
    required this.selectedStyle,
    required this.styleList,
  });

  factory StyleState.initial() {
    return StyleState(
      selectedStyle: '',
      styleList: const [],
    );
  }

  StyleState copyWith({
    String? selectedStyle,
    List<dynamic>? styleList,
  }) {
    return StyleState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      styleList: styleList ?? this.styleList,
    );
  }

  @override
  List<Object> get props => [selectedStyle];
}
