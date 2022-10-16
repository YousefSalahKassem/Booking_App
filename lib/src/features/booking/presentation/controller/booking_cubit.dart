import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';
import 'package:bookingapp/src/features/booking/domain/usecases/get_all_booking_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_booking_state.dart';

class AllBookingCubit extends Cubit<AllBookingState> {
  final GetAllBookingsUseCase getAllBookingsUseCase;

  AllBookingCubit({required this.getAllBookingsUseCase}) : super(AllBookingStatusInitial());

  static AllBookingCubit get(context) => BlocProvider.of<AllBookingCubit>(context);

  Future<void> getAllBookings(String type) async {
    emit(AllBookingStatusLoading());
    final response = await getAllBookingsUseCase(type);
    emit(response.fold(
      (failure) => AllBookingStatusError(msg: _mapFailureToMsg(failure)),
      (bookings) => AllBookingStatusComplete(
        upcomingBookings: bookings.where((element) => element.type == 'upcomming').toList(),
        cancelledBookings: bookings.where((element) => element.type == 'cancelled').toList(),
        completedBookings: bookings.where((element) => element.type == 'completed').toList(),
      ),
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
