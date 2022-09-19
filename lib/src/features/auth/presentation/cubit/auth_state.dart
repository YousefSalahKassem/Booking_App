part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthComplete extends AuthState {
  final StatusEntity auth;

  const AuthComplete({required this.auth});

  @override
  List<Object> get props => [auth];
}

class AuthError extends AuthState {
  final String msg;

  const AuthError({required this.msg});

  @override
  List<Object> get props => [msg];
}
