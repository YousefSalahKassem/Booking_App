import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';
import 'package:bookingapp/src/features/booking/domain/repository/booking_repository_abs.dart';
import 'package:dartz/dartz.dart';

class DeleteBookingsUseCase {
  final BookingRepository bookingRepository;
  final Booking booking;

  DeleteBookingsUseCase(this.bookingRepository, this.booking);

  Future<Either<Failure, Booking>> execute() async {
    return await bookingRepository.deleteBooking(booking);
  }
}