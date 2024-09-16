part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;
  LoginSuccess({required this.loginResponse});
}
final class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}
final class LoginFatalError extends LoginState {
  final String message;
  LoginFatalError({required this.message});
}