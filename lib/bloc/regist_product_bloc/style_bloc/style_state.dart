part of 'style_bloc.dart';

class StyleState extends Equatable {
  final List<String> selectedStyle;
  final List<String> styleList;
  final List<bool> isClicked;
  const StyleState({
    required this.selectedStyle,
    required this.styleList,
    required this.isClicked,
  });

  factory StyleState.initial() {
    List<String> style = [
      "로맨틱",
      "시크",
      "럭셔리",
      "미시",
      "마담",
      "오피스",
      "캐쥬얼",
      "섹시",
      "모던",
      "유니크",
      "명품 스타일",
      "연예인",
      "심플/베이직"
    ];
    return StyleState(
        selectedStyle: const [],
        styleList: style,
        isClicked: List.filled(style.length, false));
  }

  StyleState copyWith({
    List<String>? selectedStyle,
    List<String>? styleList,
    List<bool>? isClicked,
  }) {
    return StyleState(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      styleList: styleList ?? this.styleList,
      isClicked: isClicked ?? this.isClicked,
    );
  }

  @override
  List<Object> get props => [selectedStyle, styleList, isClicked];
}
