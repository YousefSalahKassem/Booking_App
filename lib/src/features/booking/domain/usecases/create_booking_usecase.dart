import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';
import 'package:bookingapp/src/features/booking/domain/repository/booking_repository_abs.dart';
import 'package:dartz/dartz.dart';

class CreateBookingsUseCase {
  final BookingRepository bookingRepository;
  final Booking booking;

  CreateBookingsUseCase(this.bookingRepository, this.booking);

  Future<Either<Failure, Booking>> execute() async {
    return await bookingRepository.createBooking(booking);
  }
}