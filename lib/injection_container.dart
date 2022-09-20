import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/app_interceptors.dart';
import 'package:bookingapp/src/core/api/dio_consumer.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/auth_usecase.dart';
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
  sl.registerFactory<AuthCubit>(() => AuthCubit(getAuthUsecase: sl()));

  // use cases
  sl.registerLazySingleton<AuthUsecase>(() => AuthUsecase(authRepository: sl()));
  sl.registerLazySingleton<GetFacilitiesUseCase>(() => GetFacilitiesUseCase(facilitiesRepository: sl()));
  sl.registerLazySingleton<GetHotelsUseCase>(() => GetHotelsUseCase(hotelsRepository: sl()));

  // repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        networkInfo: sl(),
        authRemoteDataSource: sl(),
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
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<FacilitiesRemoteDataSource>(() => FacilitiesRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<HotelsRemoteDataSource>(() => HotelsRemoteDataSourceImpl(apiConsumer: sl()));

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
