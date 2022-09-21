import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/update_booking_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/model/update_booking_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/update_book_repository.dart';

class UpdateBookRepositoryImpl implements UpdateBookingRepository {
  final UpdateBookingDataSource updateBookingDataSource;
  final NetworkInfo networkInfo;

  UpdateBookRepositoryImpl({
    required this.updateBookingDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, StatusEntity>> update(UpdateBookingModel updateBookingModel) async {
    try {
      final response = await updateBookingDataSource.updateBooking(updateBookingModel);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }


}