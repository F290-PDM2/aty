import 'dart:async';

import 'package:aty/core/errors/exceptions.dart';
import 'package:aty/core/errors/failures.dart';
import 'package:aty/features/auth/data/datasources/auth_remote_data_datasource.dart';
import 'package:aty/features/auth/domain/repositories/auth_repository.dart';
import 'package:aty/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
    : _authRemoteDataSource = authRemoteDataSource;

  @override
  Stream<UserEntity?> get onAuthStateChanged {
    final controller = StreamController<UserEntity?>();
    final subscription = _authRemoteDataSource.onAuthStateChanged.listen(
      (user) {
        controller.add(user);
      },
      onError: (error) {
        controller.add(null);
      },
    );
    controller.onCancel = () => subscription.cancel();
    return controller.stream;
  }

  @override
  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _authRemoteDataSource.login(email: email, password: password);
      return const Right(null);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.logout();
      return const Right(null);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await _authRemoteDataSource.login(email: email, password: password);
      return Right(null);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }
}
