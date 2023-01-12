import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pht_test/core/styles/app_theme.dart';
import 'package:pht_test/data/models/user/user_model.dart';
import 'package:pht_test/presentation/bloc/app_settings/app_settings_bloc.dart';
import 'package:pht_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:pht_test/presentation/screens/auth/auth_error_creen.dart';
import 'package:pht_test/presentation/screens/auth/sign_up_screen.dart';
import 'package:pht_test/presentation/screens/choose_lang/choose_lang_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pht_test/presentation/screens/home/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordObscure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.authorization),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ChooseLangScreen()), (Route<dynamic> route) => false);
              },
              icon: const Icon(
                Icons.language,
              )),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: login,
                validator: (text) {
                  if (text == "") {
                    return AppLocalizations.of(context)!.emptyFieldError;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.login,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                )
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: password,
                validator: (text) {
                  if (text == "") {
                    return AppLocalizations.of(context)!.emptyFieldError;
                  }

                  return null;
                },
                obscureText: passwordObscure,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.password,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordObscure = !passwordObscure;
                      });
                    },
                    icon: passwordObscure ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                  )
                )
              ),
              const SizedBox(height: 15,),

              BlocListener<AuthBloc, AuthState>(
                bloc: BlocProvider.of<AuthBloc>(context),
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
                  } else {
                    if (state is! AuthLoading && state is! AuthInitial) Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthErrorScreen()));
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  if (state is AuthLoading) {
                    return const SizedBox();
                  }

                  return OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          User user = User(
                              login: login.text,
                              password: password.text
                          );

                          BlocProvider.of<AuthBloc>(context).add(AuthSignInEvent(user));
                        }
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )
                          )
                      ),
                      child: Text(AppLocalizations.of(context)!.signIn)
                  );
                }),
              ),
              TextButton(
                onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                    BlocProvider.of<AuthBloc>(context).add(AuthInitEvent());
                  },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  )
                ),
                child: Text(AppLocalizations.of(context)!.signUp)
              ),
            ],
          ),
        ),
      ),
    );

  }
}
