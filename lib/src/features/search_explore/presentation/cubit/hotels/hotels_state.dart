import 'package:equatable/equatable.dart';

import '../../../domain/entities/hotels_entity.dart';

abstract class HotelsState extends Equatable {
  const HotelsState();
  @override
  List<Object> get props => [];
}

class HotelsInitial extends HotelsState {}

class HotelsLoading extends HotelsState {}

class HotelsComplete extends HotelsState {
  final List<HotelsEntity> hotels;

  const HotelsComplete({required this.hotels});

  @override
  List<Object> get props => [hotels];
}

class HotelsError extends HotelsState {
  final String msg;

  const HotelsError({required this.msg});

  @override
  List<Object> get props => [msg];
}

