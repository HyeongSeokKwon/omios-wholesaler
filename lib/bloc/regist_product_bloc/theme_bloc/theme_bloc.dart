import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ChangeThemeEvent>(changeTheme);
  }

  void changeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) {
    for (var value in state.themeList) {
      if (value['id'] == event.themeId) {
        emit(state.copyWith(selectedTheme: value['id']));
        return;
      }
    }
  }
}
