import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pht_test/core/util/env.dart';
import 'package:pht_test/data/models/user/user_model.dart';
import 'package:pht_test/presentation/screens/auth/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user = User.fromJson(jsonDecode(prefs.getString(CURRENT_USER_PREFERENCE)!));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove(CURRENT_USER_PREFERENCE);

                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (Route<dynamic> route) => false);
              },
              icon: const Icon(
                Icons.logout,
              )),
        ],
      ),

      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [

              Text(
                "${AppLocalizations.of(context)!.welcome} ${user.login}"
              ),

              const SizedBox(height: 15,),

              Image.asset("assets/images/success.png"),
            ],
          )
      ),
    );

  }
}
