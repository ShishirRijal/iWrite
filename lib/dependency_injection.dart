import 'package:get_it/get_it.dart';
import 'package:iwrite/core/secrets/app_secrets.dart';
import 'package:iwrite/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:iwrite/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:iwrite/features/auth/domain/repositories/auth_repository.dart';
import 'package:iwrite/features/auth/domain/usecases/user_sign_up.dart';
import 'package:iwrite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  await _initAuth();
}

//* Auth Service Locator
Future<void> _initAuth() async {
  // Data sources
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
            serviceLocator(),
          ));

  // Repositories
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(),
      ));

  // Use cases
  serviceLocator.registerFactory(() => UserSignUp(
        serviceLocator(),
      ));

  // Bloc
  serviceLocator.registerFactory(() => AuthBloc(
        userSignUp: serviceLocator(),
      ));
}
