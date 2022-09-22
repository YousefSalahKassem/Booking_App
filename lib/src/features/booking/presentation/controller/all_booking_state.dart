part of 'booking_cubit.dart';

abstract class AllBookingStatus extends Equatable {
  const AllBookingStatus();

  @override
  List<Object> get props => [];
}

class AllBookingStatusInitial extends AllBookingStatus {}

class AllBookingStatusLoading extends AllBookingStatus {}

class AllBookingStatusComplete extends AllBookingStatus {
  final List<Booking> upcomingBookings;
  final List<Booking> cancelledBookings;
  final List<Booking> completedBookings;

  const AllBookingStatusComplete({
    required this.upcomingBookings,
    required this.cancelledBookings,
    required this.completedBookings,
});

  @override
  List<Object> get props => [upcomingBookings, cancelledBookings, completedBookings];
}

class AllBookingStatusError extends AllBookingStatus {
  final String msg;

  const AllBookingStatusError({required this.msg});

  @override
  List<Object> get props => [msg];
}