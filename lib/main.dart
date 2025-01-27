import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/core/theme/theme.dart';
import 'package:iwrite/dependency_injection.dart';
import 'package:iwrite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:iwrite/features/auth/presentation/views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => serviceLocator<AuthBloc>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const LoginView(),
    );
  }
}
