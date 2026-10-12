import 'package:aty/core/errors/failures.dart';
import 'package:aty/core/usecase/usecase_interface.dart';
import 'package:aty/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUsecase implements UseCase<void, SignUpParams> {
  final AuthRepository _authRepository;
  SignUpUsecase({required this._authRepository});

  @override
  Future<Either<Failure, void>> call(SignUpParams params) async {
    return await _authRepository.signUp(
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String username;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.username,
  });
  @override
  List<Object?> get props => [email, password, username];
}
