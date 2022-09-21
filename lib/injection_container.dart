import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/app_interceptors.dart';
import 'package:bookingapp/src/core/api/dio_consumer.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/local/status_local_data_source.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/remote/login_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/remote/register_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/remote/status_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/data/repositories/login_repository_impl.dart';
import 'package:bookingapp/src/features/auth/data/repositories/register_repository_impl.dart';
import 'package:bookingapp/src/features/auth/data/repositories/status_repository_impl.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/login_repository.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/register_repository.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/status_repository.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/get_status_usecase.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/log_in_usecase.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/register_usecase.dart';
import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/facilities_remote_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/hotels_remote_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/repository/facilities_repository_impl.dart';
import 'package:bookingapp/src/features/search_explore/data/repository/hotels_repository_impl.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/facilities_repository.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/hotels_repository.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/get_facilities_use_case.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/get_hotels_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance; // service location instance

Future<void> init() async {
  /// features
  // cubits
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        getStatusUsecase: sl(),
        logInUseCase: sl(),
        registerUseCase: sl(),
      ));

  // use cases
  sl.registerLazySingleton<GetStatusUseCase>(() => GetStatusUseCase(statusRepository: sl()));
  sl.registerLazySingleton<LogInUseCase>(() => LogInUseCase(loginRepository: sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(registerRepository: sl()));
  sl.registerLazySingleton<GetFacilitiesUseCase>(
      () => GetFacilitiesUseCase(facilitiesRepository: sl()));
  sl.registerLazySingleton<GetHotelsUseCase>(() => GetHotelsUseCase(hotelsRepository: sl()));

  // repositories
  sl.registerLazySingleton<StatusRepository>(() => StatusRepositoryImpl(
        networkInfo: sl(),
        statusRemoteDataSource: sl(),
        statusLocalDataSource: sl(),
      ));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        networkInfo: sl(),
        loginRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(
        networkInfo: sl(),
        registerRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<FacilitiesRepository>(() => FacilitiesRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));
  sl.registerLazySingleton<HotelsRepository>(() => HotelsRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

  // data sources
  sl.registerLazySingleton<StatusRemoteDataSource>(
      () => StatusRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<StatusLocalDataSource>(
      () => StatusLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<FacilitiesRemoteDataSource>(
      () => FacilitiesRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<HotelsRemoteDataSource>(
      () => HotelsRemoteDataSourceImpl(apiConsumer: sl()));

  /// ===========================================================================================
  /// core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  /// ===========================================================================================
  /// external
  // shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // interceptors
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));

  // network info
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // dio
  sl.registerLazySingleton(() => Dio());
}
