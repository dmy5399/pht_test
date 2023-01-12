import 'dart:developer';
import 'package:pht_test/core/util/exeptions.dart';
import 'package:pht_test/data/datasources/auth/auth_datasource.dart';
import 'package:pht_test/data/datasources/auth/auth_local_datasource.dart';
import 'package:pht_test/data/models/user/user_model.dart';
import 'package:pht_test/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{

  AuthDatasource datasource = AuthLocalDatasource();

  @override
  Future<void> signUp(User user) async {
    try{
      await datasource.signUp(user);
    } on UserExistsException catch (e) {
      throw UserExistsException();
    }

  }

  @override
  Future<void> signIn(User user) async {

    try{
      await datasource.signIn(user);
    } on NoUserException catch (e) {
      throw NoUserException();
    } on IncorrectPasswordException catch (e) {
      throw IncorrectPasswordException();
    }

  }

}