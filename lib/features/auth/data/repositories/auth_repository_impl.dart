import 'package:fpdart/fpdart.dart';
import 'package:iwrite/core/error/exceptions.dart';
import 'package:iwrite/core/error/failures.dart';
import 'package:iwrite/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:iwrite/features/auth/domain/entities/user.dart';
import 'package:iwrite/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await authRemoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() func) async {
    try {
      final user = await func();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
