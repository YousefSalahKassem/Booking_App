import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';
import 'package:dartz/dartz.dart';

abstract class BookingRepository {
  Future<Either<Failure, Booking>> createBooking(Booking booking);

  Future<Either<Failure, Booking>> updateBooking(Booking booking);

  Future<Either<Failure, Booking>> deleteBooking(Booking booking);

  // abstract function which I'm working with
  //-------------------------------------------------------------
  Future<Either<Failure, List<Booking>>> getAllBookings(String type);

  // -------------------------------------------------------
  Future<Either<Failure, Booking>> getBookingById(String id);
}
