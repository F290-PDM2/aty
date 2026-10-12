import 'package:aty/core/errors/failures.dart';
import 'package:aty/core/usecase/usecase_interface.dart';
import 'package:aty/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class SignInUseCase implements UseCase<void, SignInParams> {
  final AuthRepository _authRepository;

  SignInUseCase({required this._authRepository});
  @override
  Future<Either<Failure, void>> call(SignInParams params) async {
    return await _authRepository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
