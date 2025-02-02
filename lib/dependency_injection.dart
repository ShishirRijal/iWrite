import 'package:get_it/get_it.dart';
import 'package:iwrite/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:iwrite/core/secrets/app_secrets.dart';
import 'package:iwrite/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:iwrite/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:iwrite/features/auth/domain/repositories/auth_repository.dart';
import 'package:iwrite/features/auth/domain/usecases/current_user.dart';
import 'package:iwrite/features/auth/domain/usecases/user_login.dart';
import 'package:iwrite/features/auth/domain/usecases/user_sign_up.dart';
import 'package:iwrite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:iwrite/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:iwrite/features/blog/data/repositories/blog_respository_impl.dart';
import 'package:iwrite/features/blog/domain/repositories/blog_repositories.dart';
import 'package:iwrite/features/blog/domain/usecases/get_blogs.dart';
import 'package:iwrite/features/blog/domain/usecases/upload_blog.dart';
import 'package:iwrite/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // Core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  await _initAuth();
  await _initBlog();
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

  serviceLocator.registerFactory(() => UserLogin(
        serviceLocator(),
      ));

  serviceLocator.registerFactory(() => CurrentUser(
        serviceLocator(),
      ));

  // Bloc
  serviceLocator.registerLazySingleton<AuthBloc>(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ));
}

Future<void> _initBlog() async {
  // Data sources
  serviceLocator
      .registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(
            serviceLocator(),
          ));

  // Repositories
  serviceLocator.registerFactory<BlogRepository>(() => BlogRespositoryImpl(
        serviceLocator(),
      ));

  // Use cases
  serviceLocator.registerFactory(() => UploadBlog(
        serviceLocator(),
      ));

  serviceLocator.registerFactory(() => GetBlogs(
        serviceLocator(),
      ));

  // Bloc
  serviceLocator.registerLazySingleton<BlogBloc>(() => BlogBloc(
        uploadBlog: serviceLocator(),
        getBlogs: serviceLocator(),
      ));
}
