part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthInitEvent implements AuthEvent {}

class AuthSignUpEvent implements AuthEvent {
  final User user;

  const AuthSignUpEvent(this.user);
}

class AuthSignInEvent implements AuthEvent {
  final User user;

  const AuthSignInEvent(this.user);
}
