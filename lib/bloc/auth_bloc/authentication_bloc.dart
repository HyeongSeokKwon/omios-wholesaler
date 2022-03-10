import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deepy_wholesaler/repository/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  late SharedPreferences prefs;
  bool initAutoLogin;

  AuthenticationBloc(
      {required this.authRepository, required this.initAutoLogin})
      : super(AuthenticationState.initial(initAutoLogin)) {
    on<ChangeIdEvent>(changeId);
    on<ChangePasswordEvent>(changePassword);
    on<ClickLoginButtonEvent>(clickLoginButton);
    on<ClickAutoLoginButtonEvent>(clickAutoLoginButton);
    on<AutoLoginEvent>(checkedAutoLogin);
  }

  void changeId(ChangeIdEvent event, Emitter<AuthenticationState> emit) {
    state.id = event.id;
    state.authStatus = AuthStatus.unauthenticated;
    emit(state.copyWith(id: event.id, authStatus: AuthStatus.unauthenticated));
  }

  void changePassword(
      ChangePasswordEvent event, Emitter<AuthenticationState> emit) {
    state.password = event.password;
    state.authStatus = AuthStatus.unauthenticated;
    emit(state.copyWith(
        password: event.password, authStatus: AuthStatus.unauthenticated));
  }

  void clickAutoLoginButton(ClickAutoLoginButtonEvent event,
      Emitter<AuthenticationState> emit) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('autoLogin', !state.autoLogin);
    emit(state.copyWith(autoLogin: !state.autoLogin));
  }

  Future<void> clickLoginButton(
      ClickLoginButtonEvent event, Emitter<AuthenticationState> emit) async {
    if (event.id.isEmpty || event.password.isEmpty) {
      return;
    }
    Map response = await authRepository.basicLogin(event.id, event.password);
    switch (response['code']) {
      case 201:
        authRepository.setAccessToken(response['data']['access']);
        authRepository.setRefreshToken(response['data']['refresh']);

        emit(state.copyWith(authStatus: AuthStatus.loginSuccess));
        break;

      case 400:
        emit(state.copyWith(authStatus: AuthStatus.loginFailure));
        break;
      case 401:
        emit(state.copyWith(authStatus: AuthStatus.loginFailure));
        break;
    }
  }

  Future<void> checkedAutoLogin(
      AutoLoginEvent event, Emitter<AuthenticationState> emit) async {
    prefs = await SharedPreferences.getInstance();

    bool? isAutoLoginClicked = prefs.getBool('autoLogin');
    String? refreshToken = prefs.getString('refreshToken');
    Map response;

    state.autoLogin = isAutoLoginClicked ?? false;

    if (isAutoLoginClicked == true && refreshToken != null) {
      response = await authRepository.autoLogin(refreshToken);
      switch (response['code']) {
        case 201:
          authRepository.setAccessToken(response['data']['access']);
          authRepository.setRefreshToken(response['data']['refresh']);

          emit(state.copyWith(authStatus: AuthStatus.authenticated));
          break;
        case 401:
          emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
          break;
        default:
          emit(state.copyWith(authStatus: AuthStatus.loginFailure));
      }
    } else {
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
