import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/data/datasource/booking_remote-data_source.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';
import 'package:bookingapp/src/features/booking/domain/repository/booking_repository_abs.dart';
import 'package:dartz/dartz.dart';

class BookingRepositoryImpl extends BookingRepository {

  final BookingRemoteDataSource bookingRemoteDataSource;

  BookingRepositoryImpl(this.bookingRemoteDataSource);


  @override
  Future<Either<Failure, List<Booking>>> getAllBookings(String type) async {
    final result = await bookingRemoteDataSource.getAllBookings(type);
    try {
      return Right(result);
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Booking>> createBooking(Booking booking) {
    // TODO: implement createBooking
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Booking>> deleteBooking(Booking booking) {
    // TODO: implement deleteBooking
    throw UnimplementedError();
  }



  @override
  Future<Either<Failure, Booking>> getBookingById(String id) {
    // TODO: implement getBookingById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Booking>> updateBooking(Booking booking) {
    // TODO: implement updateBooking
    throw UnimplementedError();
  }


}