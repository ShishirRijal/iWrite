import 'package:flutter/material.dart';
import 'package:iwrite/core/secrets/app_secrets.dart';
import 'package:iwrite/core/theme/theme.dart';
import 'package:iwrite/features/auth/presentation/views/login_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  runApp(const MyApp());
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
