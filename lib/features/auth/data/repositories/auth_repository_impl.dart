import 'package:fpdart/fpdart.dart';
import 'package:iwrite/core/error/exceptions.dart';
import 'package:iwrite/core/error/failures.dart';
import 'package:iwrite/core/network/connection_checker.dart';
import 'package:iwrite/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:iwrite/core/common/entities/user.dart';
import 'package:iwrite/features/auth/data/models/user_model.dart';
import 'package:iwrite/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.authRemoteDataSource, this.connectionChecker);

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
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('Internet connection not found!'));
      }
      final user = await func();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      // Check if there is an internet connection
      if (!await connectionChecker.isConnected) {
        final session = authRemoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure("User not logged in"));
        }

        return right(UserModel(
          id: session.user.id,
          name: '',
          email: session.user.email!,
        ));
      }

      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("User not logged in"));
      }
      return right(user as User);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
