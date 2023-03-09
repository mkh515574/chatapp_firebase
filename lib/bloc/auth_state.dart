part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{}
class LoginFailureState extends AuthState{
  final String errorMassage;

  LoginFailureState({required this.errorMassage});
}
