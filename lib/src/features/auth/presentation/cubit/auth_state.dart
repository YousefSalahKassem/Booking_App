part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class StatusLoading extends AuthState {}

class StatusSuccess extends AuthState {
  final BookingUser user;

  const StatusSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final BookingUser user;

  const LoginSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final BookingUser user;

  const RegisterSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String msg;

  const AuthError({required this.msg});

  @override
  List<Object> get props => [msg];
}
