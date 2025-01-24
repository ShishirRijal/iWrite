import 'package:flutter/material.dart';
import 'package:iwrite/core/theme/theme.dart';
import 'package:iwrite/features/auth/presentation/views/signup_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const SignUpView(),
    );
  }
}
