import 'package:fpdart/fpdart.dart';
import 'package:iwrite/core/error/failures.dart';
import 'package:iwrite/core/usecases/usecase.dart';
import 'package:iwrite/core/common/entities/user.dart';
import 'package:iwrite/features/auth/domain/repositories/auth_repository.dart';

class UserLogin implements UseCase<User, LoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
