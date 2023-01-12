import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pht_test/core/styles/app_theme.dart';
import 'package:pht_test/core/util/env.dart';
import 'package:pht_test/presentation/screens/auth/auth_screen.dart';
import 'package:pht_test/presentation/screens/choose_lang/choose_lang_screen.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {

  AppSettingsBloc() : super(AppSettingsInitial(homeWidget: const ChooseLangScreen())) {
    on<AppSettingsSetLangEvent>((event, emit) async {
      if(event.languageCode != null) prefs.setString(LANGUAGE_PREFERENCE, event.languageCode!);
      bool isDark = prefs.getBool(THEME_PREFERENCE) ?? false;

      emit(AppSettingsInitial(
        languageCode: prefs.getString(LANGUAGE_PREFERENCE) ?? "ru",
        homeWidget: const ChooseLangScreen(),
        themeData: isDark ? AppTheme().darkTheme : AppTheme().lightTheme
      ));
    });


    // Change theme
    on<AppSettingsChangeThemeEvent>((event, emit) async {
      bool isDark = prefs.getBool(THEME_PREFERENCE) ?? false;
      Widget homeWidget = prefs.getString(LANGUAGE_PREFERENCE) == null ? const ChooseLangScreen() : const AuthScreen();
      prefs.setBool(THEME_PREFERENCE, !isDark);

      emit(AppSettingsInitial(
        languageCode: prefs.getString(LANGUAGE_PREFERENCE) ?? "ru",
        homeWidget: homeWidget,
        themeData: !isDark ? AppTheme().darkTheme : AppTheme().lightTheme
      ));
    });

    on<AppSettingsInitEvent>((event, emit) async {
      Widget homeWidget = prefs.getString(LANGUAGE_PREFERENCE) == null ? const ChooseLangScreen() : const AuthScreen();
      bool isDark = prefs.getBool(THEME_PREFERENCE) ?? false;

      emit(AppSettingsInitial(
        languageCode: prefs.getString(LANGUAGE_PREFERENCE) ?? "ru",
        homeWidget: homeWidget,
        themeData: isDark ? AppTheme().darkTheme : AppTheme().lightTheme
      ));
    });

  }
}
