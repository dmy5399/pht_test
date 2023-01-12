part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthUserExistsError extends AuthState {}

class AuthIncorrectPasswordError extends AuthState {}

class AuthNoUserError extends AuthState {}

class AuthError extends AuthState {}
