part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  List<dynamic> themeList;
  int selectedTheme;

  ThemeState({
    required this.themeList,
    required this.selectedTheme,
  });

  factory ThemeState.initial() {
    return ThemeState(selectedTheme: 0, themeList: []);
  }

  @override
  List<Object> get props => [themeList, selectedTheme];

  ThemeState copyWith({
    List<dynamic>? themeList,
    int? selectedTheme,
  }) {
    return ThemeState(
      themeList: themeList ?? this.themeList,
      selectedTheme: selectedTheme ?? this.selectedTheme,
    );
  }
}
