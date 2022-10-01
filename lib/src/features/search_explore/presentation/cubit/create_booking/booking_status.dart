import 'package:equatable/equatable.dart';

import '../../../../auth/domain/entities/status_entity.dart';

abstract class BookingStatus extends Equatable {
  const BookingStatus();

  @override
  List<Object> get props => [];
}

class StatusInitial extends BookingStatus {}

class StatusLoading extends BookingStatus {}

class StatusComplete extends BookingStatus {
  final StatusEntity status;

  const StatusComplete({required this.status});

  @override
  List<Object> get props => [status];
}

class StatusError extends BookingStatus {
  final String msg;

  const StatusError({required this.msg});

  @override
  List<Object> get props => [msg];
}