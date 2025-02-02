import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:iwrite/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:iwrite/core/network/connection_checker.dart';
import 'package:iwrite/core/secrets/app_secrets.dart';
import 'package:iwrite/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:iwrite/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:iwrite/features/auth/domain/repositories/auth_repository.dart';
import 'package:iwrite/features/auth/domain/usecases/current_user.dart';
import 'package:iwrite/features/auth/domain/usecases/user_login.dart';
import 'package:iwrite/features/auth/domain/usecases/user_sign_up.dart';
import 'package:iwrite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:iwrite/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:iwrite/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:iwrite/features/blog/data/repositories/blog_respository_impl.dart';
import 'package:iwrite/features/blog/domain/repositories/blog_repositories.dart';
import 'package:iwrite/features/blog/domain/usecases/get_blogs.dart';
import 'package:iwrite/features/blog/domain/usecases/upload_blog.dart';
import 'package:iwrite/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // Internet Connection Checker
  serviceLocator.registerLazySingleton(() => InternetConnection());

  // Hive
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'blogs'),
  );

  // Core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));

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

  serviceLocator
      .registerFactory<BlogLocalDataSource>(() => BlogLocalDataSourceImpl(
            box: serviceLocator(),
          ));

  // Repositories
  serviceLocator.registerFactory<BlogRepository>(() => BlogRespositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
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
