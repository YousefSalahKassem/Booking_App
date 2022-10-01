part of 'booking_cubit.dart';

abstract class AllBookingState extends Equatable {
  const AllBookingState();

  @override
  List<Object> get props => [];
}

class AllBookingStatusInitial extends AllBookingState {}

class AllBookingStatusLoading extends AllBookingState {}

class AllBookingStatusComplete extends AllBookingState {
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

class AllBookingStatusError extends AllBookingState {
  final String msg;

  const AllBookingStatusError({required this.msg});

  @override
  List<Object> get props => [msg];
}