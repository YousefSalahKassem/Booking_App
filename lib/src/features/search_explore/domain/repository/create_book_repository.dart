import 'package:bookingapp/src/features/search_explore/data/model/create_book_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/status_entity.dart';

abstract class CreateBookRepository {
  Future<Either<Failure, StatusEntity>> book(CreateBookingModel createBookingModel);
}