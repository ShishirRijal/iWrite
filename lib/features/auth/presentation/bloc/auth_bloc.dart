import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/core/usecases/usecase.dart';
import 'package:iwrite/features/auth/domain/entities/user.dart';
import 'package:iwrite/features/auth/domain/usecases/current_user.dart';
import 'package:iwrite/features/auth/domain/usecases/user_login.dart';
import 'package:iwrite/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required CurrentUser currentUser})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);

    on<AuthLogin>(_onAuthLogin);

    on<AuthUserLoggedIn>(_onAuthUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
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

  void _onAuthUserLoggedIn(
      AuthUserLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _currentUser(NoParams());
    debugPrint(response.toString());
    response.fold((l) {
      emit(AuthFailure(l.message));
    }, (r) {
      emit(AuthSuccess(r));
    });
  }
}
