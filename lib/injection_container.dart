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
import 'package:bookingapp/src/features/booking/data/datasource/booking_remote-data_source.dart';
import 'package:bookingapp/src/features/booking/data/repository/booking_repository_impl.dart';
import 'package:bookingapp/src/features/booking/domain/repository/booking_repository_abs.dart';
import 'package:bookingapp/src/features/booking/domain/usecases/get_all_booking_usecase.dart';
import 'package:bookingapp/src/features/booking/presentation/controller/booking_cubit.dart';
import 'package:bookingapp/src/features/profile/data/datasource/update_info_data_source.dart';
import 'package:bookingapp/src/features/profile/data/datasource/user_info_data_source.dart';
import 'package:bookingapp/src/features/profile/data/repository/update_info_repository_impl.dart';
import 'package:bookingapp/src/features/profile/data/repository/user_profile_repository_impl.dart';
import 'package:bookingapp/src/features/profile/domain/repository/update_info_repository.dart';
import 'package:bookingapp/src/features/profile/domain/repository/user_info_repository.dart';
import 'package:bookingapp/src/features/profile/domain/usecases/get_user_info_use_case.dart';
import 'package:bookingapp/src/features/profile/domain/usecases/update_info_use_case.dart';
import 'package:bookingapp/src/features/profile/presentation/bloc/user_info/update_user_cubit.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/create_booking_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/facilities_remote_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/filter_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/hotels_remote_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/update_booking_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/repository/create_book_repositiory_impl.dart';
import 'package:bookingapp/src/features/search_explore/data/repository/facilities_repository_impl.dart';
import 'package:bookingapp/src/features/search_explore/data/repository/filter_repository_impl.dart';
import 'package:bookingapp/src/features/search_explore/data/repository/hotels_repository_impl.dart';
import 'package:bookingapp/src/features/search_explore/data/repository/update_book_repository_impl.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/create_book_repository.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/facilities_repository.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/filter_repository.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/hotels_repository.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/update_book_repository.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/create_book_use_case.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/get_facilities_use_case.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/get_filter_use_case.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/get_hotels_use_case.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/update_book_use_case.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/create_booking/booking_cubit.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/facilities/facilities_cubit.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/hotels/hotels_cubit.dart';
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

  sl.registerFactory<BookingCubit>(() => BookingCubit(
        createBookingUseCase: sl(),
        updateBookingUseCase: sl(),
      ));
  sl.registerFactory<HotelsCubit>(() => HotelsCubit(
        hotelsUseCase: sl(),
        filterUseCase: sl(),
      ));
  sl.registerFactory<AllBookingCubit>(() => AllBookingCubit(getAllBookingsUseCase: sl()));
  sl.registerFactory<UpdateUserCubit>(() => UpdateUserCubit(updateUser: sl(), getUserInfo: sl()));
  sl.registerLazySingleton<FacilitiesCubit>(() => FacilitiesCubit(getFacilitiesUseCase: sl()));

  sl.registerLazySingleton<GetStatusUseCase>(() => GetStatusUseCase(statusRepository: sl()));
  sl.registerLazySingleton<LogInUseCase>(() => LogInUseCase(loginRepository: sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(registerRepository: sl()));
  sl.registerLazySingleton<GetAllBookingsUseCase>(() => GetAllBookingsUseCase(sl()));
  sl.registerLazySingleton<GetUserInfoUseCase>(() => GetUserInfoUseCase(repository: sl()));
  // use cases
  sl.registerLazySingleton<GetFacilitiesUseCase>(
      () => GetFacilitiesUseCase(facilitiesRepository: sl()));
  sl.registerLazySingleton<GetHotelsUseCase>(() => GetHotelsUseCase(hotelsRepository: sl()));
  sl.registerLazySingleton<CreateBookingUseCase>(() => CreateBookingUseCase(repository: sl()));
  sl.registerLazySingleton<UpdateBookingUseCase>(() => UpdateBookingUseCase(repository: sl()));
  sl.registerLazySingleton<GetFilterUseCase>(() => GetFilterUseCase(filterRepository: sl()));
  sl.registerLazySingleton<UpdateInfoUseCase>(() => UpdateInfoUseCase(repository: sl()));
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
  sl.registerLazySingleton<CreateBookRepository>(
      () => CreateBookingRepositoryImpl(networkInfo: sl(), createBookingDataSource: sl()));
  sl.registerLazySingleton<UpdateBookingRepository>(
      () => UpdateBookRepositoryImpl(networkInfo: sl(), updateBookingDataSource: sl()));
  sl.registerLazySingleton<FilterRepository>(
      () => FilterRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(sl()));
  sl.registerLazySingleton<UpdateInfoRepository>(() => UpdateInfoRepositoryImpl(remoteDataSource: sl(),));
  sl.registerLazySingleton<UserInfoRepository>(() => UserProfileRepositoryImpl(dataSource: sl(),));
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
  sl.registerLazySingleton<UpdateBookingDataSource>(
      () => UpdateBookingDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<FilterRemoteDataSource>(
      () => FilterRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<BookingRemoteDataSource>(
      () => BookingRemoteDataSourceImpl(apiConsumer: sl()));

  sl.registerLazySingleton<CreateBookingDataSource>(() => CreateBookingDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<UpdateInfoDataSource>(() => UpdateInfoDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<UserInfoDataSource>(() => UserInfoDataSourceImpl(consumer: sl()));
  // remote

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
