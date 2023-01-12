import 'dart:convert';
import 'dart:developer';

import 'package:pht_test/core/util/env.dart';
import 'package:pht_test/core/util/exeptions.dart';
import 'package:pht_test/data/datasources/auth/auth_datasource.dart';
import 'package:pht_test/data/models/user/user_model.dart';

class AuthLocalDatasource implements AuthDatasource {

  @override
  Future<void> signIn(User user) async {
    bool flag = false;

    List<String> jsonUsers = prefs.getStringList(USER_PREFERENCE) ?? [];

    for(String jsonUser in jsonUsers) {
      User usr = User.fromJson(jsonDecode(jsonUser));

      if(usr.login == user.login) {
        flag = true;
        if(usr.password != user.password) throw IncorrectPasswordException();
      }

    }

    if(!flag) {
      throw NoUserException();
    }
  }

  @override
  Future<void> signUp(User user) async {
    bool flag = false;

    List<String> jsonUsers = prefs.getStringList(USER_PREFERENCE) ?? [];

    List<User> users = [];

    for(String jsonUser in jsonUsers) {
      User usr = User.fromJson(jsonDecode(jsonUser));

      if(usr.login == user.login) flag = true;

      users.add(usr);
    }

    if(flag) {
      throw UserExistsException();
    } else {
      users.add(user);

      prefs.setStringList(USER_PREFERENCE, [for(User usr in users) jsonEncode(usr.toJson())]);

    }

  }

}