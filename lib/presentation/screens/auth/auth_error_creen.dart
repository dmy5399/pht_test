import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pht_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthErrorScreen extends StatefulWidget {
  const AuthErrorScreen({Key? key}) : super(key: key);

  @override
  State<AuthErrorScreen> createState() => _AuthErrorScreenState();
}

class _AuthErrorScreenState extends State<AuthErrorScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {

              if (state is AuthUserExistsError) {
                return Text(
                  AppLocalizations.of(context)!.signUpUserExistsError,
                  style: const TextStyle(
                      color: Colors.red
                  ),
                );
              }

              if (state is AuthNoUserError) {
                return Text(
                  AppLocalizations.of(context)!.noUserErrorError,
                  style: const TextStyle(
                      color: Colors.red
                  ),
                );
              }

              if (state is AuthIncorrectPasswordError) {
                return Text(
                  AppLocalizations.of(context)!.incorrectPasswordError,
                  style: const TextStyle(
                      color: Colors.red
                  ),
                );
              }

              if (state is AuthError) {
                return const Text(
                  'Error',
                  style: TextStyle(
                      color: Colors.red
                  ),
                );
              }

              return const SizedBox();
            }),

            const SizedBox(height: 15,),

            Image.asset("assets/images/failure.png"),
          ],
        )
      ),
    );

  }
}
