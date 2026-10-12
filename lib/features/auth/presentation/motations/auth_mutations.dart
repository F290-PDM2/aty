import 'package:aty/core/errors/presentation_failure_exeption.dart';
import 'package:aty/features/auth/domain/usecases/signin_usecase.dart';
import 'package:aty/features/auth/domain/usecases/signup_usecase.dart';
import 'package:aty/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signinMutation = Mutation<void>();
final signupMutation = Mutation<void>();

Future<void> runSignin({
  required WidgetRef ref,
  required String email,
  required String password,
}) async {
  await signinMutation.run(ref, (tsx) async {
    final useCase = tsx.get(signInUsecaseProvider);
    var result = await useCase(SignInParams(email: email, password: password));

    result.fold(
      (failure) => throw PresentationFailureException(failure),
      (_) => null,
    );
  });
}

Future<void> runSignup({
  required WidgetRef ref,
  required String email,
  required String password,
  required String username,
}) async {
  await signupMutation.run(ref, (tsx) async {
    final useCase = tsx.get(signupUsecaseProvider);
    var result = await useCase(
      SignUpParams(email: email, password: password, username: username),
    );

    result.fold(
      (failure) => throw PresentationFailureException(failure),
      (_) => null,
    );
  });
}
