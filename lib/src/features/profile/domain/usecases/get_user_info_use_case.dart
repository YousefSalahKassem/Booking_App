import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:bookingapp/src/features/profile/domain/repository/user_info_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserInfoUseCase extends UseCase<BookingUser, NoParams> {
  final UserInfoRepository repository;

  GetUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, BookingUser>> call(params) {
    return repository.getUserInfo();
  }
}
