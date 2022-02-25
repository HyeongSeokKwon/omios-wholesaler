import 'dart:async';

import 'package:deepy_wholesaler/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  late final StreamSubscription authSubscription;

  AuthenticationBloc({required this.authRepository})
      : super(AuthenticationState.initial()) {
    on<ChangeIdEvent>(changeId);
    on<ChangePasswordEvent>(changePassword);
    on<ClickLoginButtonEvent>(clickLoginButton);
  }

  void changeId(ChangeIdEvent event, Emitter<AuthenticationState> emit) {
    state.id = event.id;
    emit(state.copyWith(id: event.id, authStatus: AuthStatus.init));
  }

  void changePassword(
      ChangePasswordEvent event, Emitter<AuthenticationState> emit) {
    state.password = event.password;
    emit(state.copyWith(password: event.password, authStatus: AuthStatus.init));
  }

  Future<void> clickLoginButton(
      ClickLoginButtonEvent event, Emitter<AuthenticationState> emit) async {
    Map response = await authRepository.basicLogin(event.id, event.password);
    switch (response['code']) {
      case 201:
        authRepository.setAccessToken(response['data']['access']);
        authRepository.setRefreshToken(response['data']['refresh']);

        emit(state.copyWith(authStatus: AuthStatus.success));
        break;

      case 401:
        emit(state.copyWith(authStatus: AuthStatus.failure));
        break;
    }
  }
}
