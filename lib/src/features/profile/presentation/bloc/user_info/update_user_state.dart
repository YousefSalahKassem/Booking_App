import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:bookingapp/src/features/profile/domain/entity/update_info_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final BookingUser updateInfoEntity;

  const UpdateUserSuccess({required this.updateInfoEntity});

  @override
  List<Object> get props => [updateInfoEntity];
}

class UpdateUserFailure extends UpdateUserState {
  final String message;

  const UpdateUserFailure({required this.message});

  @override
  List<Object> get props => [message];
}