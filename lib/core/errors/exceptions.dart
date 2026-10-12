class AppException implements Exception {
  final String message;

  AppException({required this.message});

  @override
  String toString() => '${runtimeType.toString()}: $message';
}

class AuthenticationException extends AppException {
  AuthenticationException({required super.message});
}

class DatabaseException extends AppException {
  DatabaseException({required super.message});
}

class PermissionException extends AppException {
  PermissionException({required super.message});
}

class NotFoundException extends AppException {
  NotFoundException({required super.message});
}

class StorageServerException extends AppException {
  StorageServerException({required super.message});
}

class NetworkException extends AppException {
  NetworkException({
    super.message =
        'Network error occurred. '
        'Please check your internet connection and try again.',
  });
}

class UnknownException extends AppException {
  UnknownException({super.message = 'An unknown error occurred.'});
}
