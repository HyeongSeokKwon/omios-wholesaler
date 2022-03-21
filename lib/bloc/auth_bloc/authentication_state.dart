part of 'authentication_bloc.dart';

enum AuthStatus {
  deviceInit,
  authenticated,
  unauthenticated,
  loginSuccess,
  loginFailure,
  loading
}

class AuthenticationState extends Equatable {
  final String id;
  final String password;
  final bool autoLogin;
  final AuthStatus authStatus;

  const AuthenticationState({
    required this.id,
    required this.password,
    required this.autoLogin,
    required this.authStatus,
  });

  factory AuthenticationState.initial(bool autoLogin) {
    return AuthenticationState(
        id: '',
        password: '',
        autoLogin: autoLogin,
        authStatus: AuthStatus.deviceInit);
  }

  @override
  List<Object> get props => [id, password, autoLogin, authStatus];

  @override
  String toString() {
    return 'AuthenticationState(id: $id, password: $password, autoLogin: $autoLogin, authStatus: $authStatus)';
  }

  AuthenticationState copyWith({
    String? id,
    String? password,
    bool? autoLogin,
    AuthStatus? authStatus,
  }) {
    return AuthenticationState(
      id: id ?? this.id,
      password: password ?? this.password,
      autoLogin: autoLogin ?? this.autoLogin,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
