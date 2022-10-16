import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/search_explore/data/model/create_book_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/create_book_repository.dart';
import 'package:dartz/dartz.dart';

class CreateBookingUseCase extends UseCase<StatusEntity, CreateBookingModel> {
  final CreateBookRepository repository;

  CreateBookingUseCase({required this.repository});

  @override
  Future<Either<Failure, StatusEntity>> call(params) async {
    return await repository.book(params);
  }
}
