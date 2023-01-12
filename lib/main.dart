import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pht_test/core/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pht_test/presentation/bloc/app_settings/app_settings_bloc.dart';
import 'package:pht_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/util/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppSettingsBloc>(
          create: (BuildContext context) => AppSettingsBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Builder(
          builder: (context) {
            BlocProvider.of<AppSettingsBloc>(context).add(AppSettingsInitEvent());

            return BlocBuilder<AppSettingsBloc, AppSettingsState>(
              builder: (context, state) {

                if (state is AppSettingsInitial) {
                  return MaterialApp(
                    title: 'Auth test app',
                    debugShowCheckedModeBanner: false,
                    theme: state.themeData,
                    locale: Locale(state.languageCode),
                    supportedLocales: L10n.all,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    home: state.homeWidget,
                  );
                }

                return const Center(child: Text("AppSettings Error"));
              },
            );
          }
        ),
      ),
    );
  }
}

