import 'package:aty/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Stream<UserModel?> get onAuthStateChanged;

  Future<UserModel?> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();
} 