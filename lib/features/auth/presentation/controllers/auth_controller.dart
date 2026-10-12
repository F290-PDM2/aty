import 'dart:async';

import 'package:aty/core/usecase/usecase_interface.dart';
import 'package:aty/features/auth/domain/entities/user_entity.dart';
import 'package:aty/features/auth/presentation/providers/auth_providers.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState._({required this.status, this.user});

  const AuthState.unknown() : this._(status: AuthStatus.unknown);

  const AuthState.authenticated(UserEntity user)
    : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final UserEntity? user;

  @override
  List<Object?> get props => [status, user];
}

@riverpod
class AuthController extends _$AuthController {
  StreamSubscription<UserEntity?>? _authStateSubscription;
  @override
  AuthState build() {
    _authStateSubscription = ref
        .watch(authRepositoryProvider)
        .onAuthStateChanged
        .listen(
          (user) => user != null
              ? state = AuthState.authenticated(user)
              : state = AuthState.unauthenticated(),
          onError: (error) => state = const AuthState.unauthenticated(),
        );

    ref.onDispose(() {
      _authStateSubscription?.cancel();
      _authStateSubscription = null;
    });
    return const AuthState.unknown();
  }

  Future<void> logout() async {
    final useCase = ref.read(signOutUseCaseProvider);
    await useCase(NoParams());
  }
}
