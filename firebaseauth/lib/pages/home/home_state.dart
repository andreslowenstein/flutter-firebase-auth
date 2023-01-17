part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoginLoading extends HomeState {}

class LoginError extends HomeState {
  final String error;

  LoginError(this.error);
}

class RegisterLoading extends HomeState {}

class RegisterError extends HomeState {}

class HomeLoaded extends HomeState {}

class GetMemeLoading extends HomeState {}

class GetMemeLoaded extends HomeState {}
