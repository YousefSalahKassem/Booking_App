import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class StatusInitial extends BookingState {}

class StatusLoading extends BookingState {}

class StatusComplete extends BookingState {
  final StatusEntity status;

  const StatusComplete({required this.status});

  @override
  List<Object> get props => [status];
}

class StatusError extends BookingState {
  final String msg;

  const StatusError({required this.msg});

  @override
  List<Object> get props => [msg];
}
