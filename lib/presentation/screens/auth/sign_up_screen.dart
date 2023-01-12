import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pht_test/data/models/user/user_model.dart';
import 'package:pht_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:pht_test/presentation/screens/auth/auth_error_creen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pht_test/presentation/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool passwordObscure = true;
  bool confirmPasswordObscure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signUp),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                  obscureText: passwordObscure,
                  validator: (text) {
                    if (text == "") {
                      return AppLocalizations.of(context)!.emptyFieldError;
                    }

                    return null;
                  },
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
              TextFormField(
                  controller: confirmPassword,
                  obscureText: confirmPasswordObscure,
                  validator: (text) {
                    if (text != password.text) {
                      return AppLocalizations.of(context)!.passwordMatchError;
                    }

                    if (text == "") {
                      return AppLocalizations.of(context)!.emptyFieldError;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.confirmPassword,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            confirmPasswordObscure = !confirmPasswordObscure;
                          });
                        },
                        icon: confirmPasswordObscure ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                      )
                  )
              ),
              const SizedBox(height: 15,),

              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
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

                        BlocProvider.of<AuthBloc>(context).add(AuthSignUpEvent(user));
                      }
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                        )
                    ),
                    child: Text(AppLocalizations.of(context)!.signUp)
                );
              }),


            ],
          ),
        ),
      ),
    );
  }
}
