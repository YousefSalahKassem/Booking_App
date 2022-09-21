import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';
import 'package:bookingapp/src/features/booking/domain/repository/booking_repository_abs.dart';
import 'package:dartz/dartz.dart';

class GetAllBookingsUseCase {
  final BookingRepository bookingRepository;

  GetAllBookingsUseCase(this.bookingRepository);

  Future<Either<Failure, List<Booking>>> execute() async {
    return await bookingRepository.getAllBookings();
  }
}