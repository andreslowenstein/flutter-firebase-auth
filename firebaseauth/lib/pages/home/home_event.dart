part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends HomeEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

class RegisterEvent extends HomeEvent {
  final String email;
  final String password;

  RegisterEvent({
    required this.email,
    required this.password,
  });
}

class LogoutEvent extends HomeEvent {}

class GetMemes extends HomeEvent {}
