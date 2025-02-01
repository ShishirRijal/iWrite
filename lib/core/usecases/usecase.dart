import 'package:fpdart/fpdart.dart';
import 'package:iwrite/core/error/failures.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// In case we need no parameters
class NoParams {
  const NoParams();
}
