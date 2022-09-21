import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/search_explore/data/model/create_book_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/create_book_use_case.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/create_booking/booking_status.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/update_booking_model.dart';
import '../../../domain/use_cases/update_book_use_case.dart';

class BookingCubit extends Cubit<BookingStatus> {
  final CreateBookingUseCase createBookingUseCase;
  final UpdateBookingUseCase updateBookingUseCase;
  BookingCubit({required this.createBookingUseCase, required this.updateBookingUseCase}) : super(StatusInitial());

  static BookingCubit get(context) => BlocProvider.of<BookingCubit>(context);

  Future<void> createBooking(CreateBookingModel createBookingModel) async {
    emit(StatusLoading());
    Either<Failure,StatusEntity> response = await createBookingUseCase(createBookingModel);
    emit(response.fold(
      (failure) => StatusError(msg: _mapFailureToMsg(failure)),
      (status) => StatusComplete(status: status),
    ));
  }

  Future<void> updateBooking(UpdateBookingModel updateBookingModel) async {
    emit(StatusLoading());
    Either<Failure,StatusEntity> response = await updateBookingUseCase(updateBookingModel);
    emit(response.fold(
      (failure) => StatusError(msg: _mapFailureToMsg(failure)),
      (status) => StatusComplete(status: status),
    ));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}