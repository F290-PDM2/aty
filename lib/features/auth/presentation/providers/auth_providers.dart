import 'package:aty/core/providers/core_providers.dart';
import 'package:aty/features/auth/data/datasources/auth_remote_data_datasource.dart';
import 'package:aty/features/auth/data/datasources/supabase_auth_remote_data_datasource.dart';
import 'package:aty/features/auth/data/repositories/auth_repository.dart';
import 'package:aty/features/auth/domain/repositories/auth_repository.dart';
import 'package:aty/features/auth/domain/usecases/signin_usecase.dart';
import 'package:aty/features/auth/domain/usecases/signout_usecase.dart';
import 'package:aty/features/auth/domain/usecases/signup_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

// Data
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return SupabaseAuthRemoteDataSource(
    supabaseClient: ref.watch(supabaseClientProvider),
  );
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
  );
}

// Domain
@riverpod
SignUpUsecase signupUsecase(Ref ref) {
  return SignUpUsecase(authRepository: ref.watch(authRepositoryProvider));
}

@riverpod
SignInUseCase signInUsecase(Ref ref) {
  return SignInUseCase(authRepository: ref.watch(authRepositoryProvider));
}

@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  return SignOutUseCase(authRepository: ref.watch(authRepositoryProvider));
}
