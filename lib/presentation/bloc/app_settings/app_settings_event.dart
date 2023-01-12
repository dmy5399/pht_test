part of 'app_settings_bloc.dart';

@immutable
abstract class AppSettingsEvent {}

class AppSettingsSetLangEvent implements AppSettingsEvent {
  final String? languageCode;

  AppSettingsSetLangEvent({
    this.languageCode,
  });
}

class AppSettingsChangeThemeEvent implements AppSettingsEvent {}

class AppSettingsInitEvent implements AppSettingsEvent {}
