import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/core/common/widgets/custom_loading_indicator.dart';
import 'package:iwrite/core/theme/app_pallete.dart';
import 'package:iwrite/core/utils/show_snackbar.dart';
import 'package:iwrite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:iwrite/features/auth/presentation/views/signup_view.dart';
import 'package:iwrite/features/auth/presentation/widgets/custom_button.dart';
import 'package:iwrite/features/auth/presentation/widgets/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => LoginView());
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  void login() {
    context.read<AuthBloc>().add(
          AuthLogin(
              email: _emailController.text, password: _passwordController.text),
        );
  }

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Form(
              key: _formKey,
              child:
                  BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                if (state is AuthFailure) {
                  showErrorSnackbar(context, state.message);
                }
              }, builder: (context, state) {
                if (state is AuthLoading) {
                  return CustomLoadingIndicator();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Text("Sign in.",
                        style: TextStyle(
                          fontSize: 50,
                          color: AppPallete.whiteColor,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),

                    // Email
                    CustomTextFormField(
                        controller: _emailController, hintText: "Email"),

                    // Password
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: "Password",
                      isPassword: true,
                    ),

                    // Sign Up Button
                    CustomButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      text: "Sign in",
                    ),

                    // Already have an account?
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, SignUpView.route());
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "Don't have an account yet? ",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                            TextSpan(
                                text: "Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold,
                                    )),
                          ])),
                    )
                  ],
                );
              }),
            ),
          ),
        ));
  }
}
