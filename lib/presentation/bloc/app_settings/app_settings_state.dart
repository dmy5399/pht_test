part of 'app_settings_bloc.dart';

@immutable
abstract class AppSettingsState {}

class AppSettingsInitial extends AppSettingsState {
  final String languageCode;
  final Widget homeWidget;
  final ThemeData? themeData;

  AppSettingsInitial({
    this.languageCode = 'ru',
    required this.homeWidget,
    this.themeData,
  });
}
