import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final BookingUser user;

  const UpdateUserSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdateUserFailure extends UpdateUserState {
  final String message;

  const UpdateUserFailure({required this.message});

  @override
  List<Object> get props => [message];
}
