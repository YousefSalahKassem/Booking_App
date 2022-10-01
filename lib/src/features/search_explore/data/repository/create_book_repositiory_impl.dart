import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/create_booking_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/model/create_book_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/create_booking_entity.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/create_book_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class CreateBookingRepositoryImpl implements CreateBookRepository {
  final NetworkInfo networkInfo;
  final CreateBookingDataSource createBookingDataSource;

  CreateBookingRepositoryImpl({
    required this.networkInfo,
    required this.createBookingDataSource,
  });

  @override
  Future<Either<Failure, StatusEntity>> book(CreateBookingModel createBookingModel) async{
    try{
      final response = await createBookingDataSource.createBooking(createBookingModel);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}