part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String error;
  const LoginError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'Login Error (error: $error)';
  }
}
