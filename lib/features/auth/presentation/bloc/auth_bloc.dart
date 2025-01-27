import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final response = await _userSignUp(
        SignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      print(response);

      response.fold((l) {
        emit(AuthFailure(l.message));
      }, (r) {
        emit(AuthSuccess(r));
      });
    });
  }
}
