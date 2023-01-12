import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pht_test/core/util/env.dart';
import 'package:pht_test/core/util/exeptions.dart';
import 'package:pht_test/data/models/user/user_model.dart';
import 'package:pht_test/data/repositories/auth_repository_impl.dart';
import 'package:pht_test/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthInitEvent>((event, emit) async {
      emit(AuthInitial());
    });

    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoading());

      AuthRepository repository = AuthRepositoryImpl();

      try{
        await repository.signUp(event.user);
        prefs.setString(CURRENT_USER_PREFERENCE, jsonEncode(event.user.toJson()));

        emit(AuthSuccess());
      } on UserExistsException catch(_) {
        emit(AuthUserExistsError());
      } catch(_) {
        emit(AuthError());
      }

    });

    on<AuthSignInEvent>((event, emit) async {
      emit(AuthLoading());

      AuthRepository repository = AuthRepositoryImpl();

      try{
        await repository.signIn(event.user);
        prefs.setString(CURRENT_USER_PREFERENCE, jsonEncode(event.user.toJson()));

        emit(AuthSuccess());
      } on NoUserException catch (e) {
        emit(AuthNoUserError());
      } on IncorrectPasswordException catch (e) {
        emit(AuthIncorrectPasswordError());
      } catch(_) {
        emit(AuthError());
      }

    });
  }
}
