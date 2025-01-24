import 'package:flutter/material.dart';
import 'package:iwrite/core/theme/app_pallete.dart';
import 'package:iwrite/features/auth/presentation/widgets/custom_button.dart';
import 'package:iwrite/features/auth/presentation/widgets/custom_text_form_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  void submit() {}

  void validate() {}

  // text controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              Text("Sign Up.",
                  style: TextStyle(
                    fontSize: 50,
                    color: AppPallete.whiteColor,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),

              // Name
              CustomTextFormField(
                  controller: _nameController, hintText: "Name"),

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
                onPressed: () {},
                text: "Sign Up",
              ),

              // Already have an account?
              RichText(
                  text: TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                    TextSpan(
                        text: "Sign in",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                )),
                  ]))
            ],
          ),
        ),
      ),
    ));
  }
}
