part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class StatusLoading extends AuthState {}

class StatusComplete extends AuthState {
  final StatusEntity status;

  const StatusComplete({required this.status});

  @override
  List<Object> get props => [status];
}

class LoginLoading extends AuthState {}

class LoginComplete extends AuthState {
  final StatusEntity status;

  const LoginComplete({required this.status});

  @override
  List<Object> get props => [status];
}

class RegisterLoading extends AuthState {}

class RegisterComplete extends AuthState {
  final StatusEntity status;

  const RegisterComplete({required this.status});

  @override
  List<Object> get props => [status];
}

class AuthError extends AuthState {
  final String msg;

  const AuthError({required this.msg});

  @override
  List<Object> get props => [msg];
}
