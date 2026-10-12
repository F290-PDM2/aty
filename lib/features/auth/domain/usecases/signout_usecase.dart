import 'package:aty/core/errors/failures.dart';
import 'package:aty/core/usecase/usecase_interface.dart';
import 'package:aty/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  SignOutUseCase({required this._authRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _authRepository.signOut();
  }
}
