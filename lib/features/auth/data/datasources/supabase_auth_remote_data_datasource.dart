import 'dart:io';

import 'package:aty/core/errors/exceptions.dart';
import 'package:aty/features/auth/data/datasources/auth_remote_data_datasource.dart'
    show AuthRemoteDataSource;
import 'package:aty/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;
  SupabaseAuthRemoteDataSource({required this._supabaseClient});

  @override
  Stream<UserModel?> get onAuthStateChanged {
    return _supabaseClient.auth.onAuthStateChange.map((state) {
      final user = state.session?.user;
      if (user == null) return null;
      return UserModel.fromSupabaseUser(user);
    });
  }

  @override
  Future<UserModel> login({required String email, required String password}) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;

      if (user == null) {
        throw AuthenticationException(
          message: 'Login realizado com sucesso, mas não foi possível recuperar as informações do usuário.',
        );
      }
      return UserModel.fromSupabaseUser(user);
    } on AuthException catch (e) {
      throw AuthenticationException(message: e.message);
    } on AuthenticationException {
      rethrow;
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw UnknownException(
        message: 'Uma exceção inesperdada ocorreu no login: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw AuthenticationException(message: e.message);
    } on AuthenticationException {
      rethrow;
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw UnknownException(
        message: 'Uma exceção inesperdada ocorreu no logout: ${e.toString()}',
      );
    }
  }

  @override
  Future<UserModel?> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'username': username, 'role': 'user'},
      );
      final user = response.user;

      if (user == null) {
        throw AuthenticationException(
          message: 'Usuário criado com sucesso, mas não foi possível recuperar as informações do usuário.',
        );
      }
      return UserModel.fromSupabaseUser(user);
    } on AuthException catch (e) {
      throw AuthenticationException(message: e.message);
    } on AuthenticationException {
      rethrow;
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw UnknownException(
        message: 'Uma exceção inesperdada ocorreu no cadastro: ${e.toString()}',
      );
    }
  }
}
