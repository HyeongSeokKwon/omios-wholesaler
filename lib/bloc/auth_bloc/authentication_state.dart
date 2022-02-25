part of 'authentication_bloc.dart';

enum AuthStatus { init, success, loading, failure }

class AuthenticationState extends Equatable {
  String id;
  String password;
  AuthStatus authStatus;

  AuthenticationState({
    required this.id,
    required this.password,
    required this.authStatus,
  });

  factory AuthenticationState.initial() {
    return AuthenticationState(
        id: '', password: '', authStatus: AuthStatus.init);
  }

  @override
  List<Object> get props => [id, password, authStatus];

  @override
  String toString() =>
      'AuthenticationState(id: $id, password: $password, authStatus: $authStatus)';

  AuthenticationState copyWith({
    String? id,
    String? password,
    AuthStatus? authStatus,
  }) {
    return AuthenticationState(
      id: id ?? this.id,
      password: password ?? this.password,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
