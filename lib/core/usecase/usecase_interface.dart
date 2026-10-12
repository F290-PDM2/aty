import 'package:aty/core/errors/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<ReturnType, ParamsType> {
  Future<Either<Failure, ReturnType>> call(ParamsType params);
}


class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}
