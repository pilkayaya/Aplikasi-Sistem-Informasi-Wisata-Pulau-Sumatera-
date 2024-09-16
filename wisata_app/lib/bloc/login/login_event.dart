part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginPressed extends LoginEvent{
  final AuthParam authParam;
  LoginPressed({required this.authParam});
}
final class LoginReset extends LoginEvent{}
