import 'package:pht_test/data/models/user/user_model.dart';

abstract class AuthDatasource {
  Future<void> signUp(User user);

  Future<void> signIn(User user);
}