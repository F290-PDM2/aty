import 'package:aty/core/errors/failures.dart';

class PresentationFailureException implements Exception {
  final Failure failure;

  PresentationFailureException(this.failure);

  @override
  String toString() => 'PresentationFailureException: ${failure.message}';

  String presentationFailureMessage(Object error) {
    if (error is PresentationFailureException) return error.failure.message;
    if (error is Failure) return error.message;
    return error.toString();
  }
}
