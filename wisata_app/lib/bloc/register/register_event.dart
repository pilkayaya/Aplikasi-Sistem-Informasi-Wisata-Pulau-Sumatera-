part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterPressed extends RegisterEvent{
  final RegisterParam registerParam;
  RegisterPressed({required this.registerParam});
}
