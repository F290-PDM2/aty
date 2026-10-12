import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const new({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => '${runtimeType.toString()}: $message';
}

class ServerFailure extends Failure {
  const new({required super.message});
}

class NetworkFailure extends Failure {
  const new({super.message = 'Por favor, cheque sua conexão...'});
}

class AuthenticationFailure extends Failure {
  const new({required super.message});
}

class PermissionFailure extends Failure {
  const new({required super.message});
}

class NotFoundFailure extends Failure {
  const new({required super.message});
}

class ConnectionFailure extends Failure {
  const new({required super.message});
}

class UnknownFailure extends Failure {
  const new({required super.message});
}
