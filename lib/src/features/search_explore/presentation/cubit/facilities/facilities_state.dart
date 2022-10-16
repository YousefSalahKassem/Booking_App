part of 'facilities_cubit.dart';

abstract class FacilitiesState extends Equatable {
  const FacilitiesState();

  @override
  List<Object> get props => [];
}

class FacilitiesInitial extends FacilitiesState {}

class FacilitiesLoading extends FacilitiesState {}

class FacilitiesComplete extends FacilitiesState {
  final List<FacilitiesEntity> facilities;

  const FacilitiesComplete({required this.facilities});

  @override
  List<Object> get props => [facilities];
}

class FacilitiesError extends FacilitiesState {
  final String msg;

  const FacilitiesError({required this.msg});

  @override
  List<Object> get props => [msg];
}
