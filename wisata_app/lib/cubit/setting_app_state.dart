part of 'setting_app_cubit.dart';

@immutable
sealed class SettingAppState {}

final class SettingAppInitial extends SettingAppState {}

final class SettingAppAuthenticated extends SettingAppState {}

final class SettingAppUnAuthenticated extends SettingAppState {}
