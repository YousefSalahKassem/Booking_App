import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';
import 'package:bookingapp/src/features/booking/domain/repository/booking_repository_abs.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';

class GetAllBookingsUseCase implements UseCase<List<Booking>, String> {
  final BookingRepository bookingRepository;

  GetAllBookingsUseCase(this.bookingRepository);

  @override
  Future<Either<Failure, List<Booking>>> call(params) async {
    return bookingRepository.getAllBookings(params);
  }
}