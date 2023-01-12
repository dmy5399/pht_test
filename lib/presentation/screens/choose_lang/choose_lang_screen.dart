import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pht_test/core/styles/app_theme.dart';
import 'package:pht_test/presentation/bloc/app_settings/app_settings_bloc.dart';
import 'package:pht_test/presentation/screens/auth/auth_screen.dart';

class ChooseLangScreen extends StatefulWidget {
  const ChooseLangScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLangScreen> createState() => _ChooseLangScreenState();
}

class _ChooseLangScreenState extends State<ChooseLangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

          BlocBuilder<AppSettingsBloc, AppSettingsState>(
            builder: (context, state) {

              if (state is AppSettingsInitial) {
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<AppSettingsBloc>(context).add((AppSettingsChangeThemeEvent()));
                    },
                    icon: Icon(
                      state.themeData == AppTheme().darkTheme ? Icons.sunny : Icons.nightlight_round_rounded,
                    ));
              }

              return const Placeholder();
            },
          )

        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (Route<dynamic> route) => false);
                    BlocProvider.of<AppSettingsBloc>(context).add(AppSettingsSetLangEvent(languageCode: 'ru'));
                  },
                  child: const Text('Русский')),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (Route<dynamic> route) => false);
                    BlocProvider.of<AppSettingsBloc>(context).add(AppSettingsSetLangEvent(languageCode: 'en'));
                  },
                  child: const Text('English')),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
