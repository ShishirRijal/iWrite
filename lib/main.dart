import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:iwrite/core/theme/theme.dart';
import 'package:iwrite/dependency_injection.dart';
import 'package:iwrite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:iwrite/features/auth/presentation/views/login_view.dart';
import 'package:iwrite/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:iwrite/features/blog/presentation/views/blog_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => serviceLocator<AppUserCubit>(),
    ),
    BlocProvider(
      create: (context) => serviceLocator<AuthBloc>(),
    ),
    BlocProvider(
      create: (context) => serviceLocator<BlogBloc>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return BlogView();
          }

          return const LoginView();
        },
      ),
    );
  }
}
