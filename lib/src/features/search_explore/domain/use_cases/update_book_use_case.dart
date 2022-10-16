import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/search_explore/data/model/update_booking_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/update_book_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateBookingUseCase extends UseCase<StatusEntity, UpdateBookingModel> {
  final UpdateBookingRepository repository;

  UpdateBookingUseCase({required this.repository});

  @override
  Future<Either<Failure, StatusEntity>> call(params) async {
    return await repository.update(params);
  }
}
