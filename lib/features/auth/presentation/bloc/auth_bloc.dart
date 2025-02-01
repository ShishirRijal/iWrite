import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/features/auth/domain/entities/user.dart';
import 'package:iwrite/features/auth/domain/usecases/user_login.dart';
import 'package:iwrite/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);

    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    print('loading emitted');

    final response = await _userSignUp(
      SignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    debugPrint(response.toString());

    response.fold((l) {
      emit(AuthFailure(l.message));
    }, (r) {
      emit(AuthSuccess(r));
    });
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    print('loading emitted');

    final response = await _userLogin(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    debugPrint(response.toString());

    response.fold((l) {
      emit(AuthFailure(l.message));
    }, (r) {
      emit(AuthSuccess(r));
    });
  }
}
