import 'package:aty/core/errors/failures.dart';
import 'package:aty/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Stream<UserEntity?> get onAuthStateChanged;

  Future<Either<Failure, void>> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOut();
}
