import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/search_explore/data/model/create_book_model.dart';
import 'package:dartz/dartz.dart';

abstract class CreateBookRepository {
  Future<Either<Failure, StatusEntity>> book(CreateBookingModel createBookingModel);
}
