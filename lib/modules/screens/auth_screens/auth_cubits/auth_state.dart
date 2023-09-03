part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class RegisterSuccessState extends AuthState{}
class RegisterFailureState extends AuthState{
  String errMessage;
  RegisterFailureState({required this.errMessage});
}
class RegisterLoadingState extends AuthState{}
class RegisterPasswordState extends AuthState{}


class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{}
class LoginFailureState extends AuthState{
  String errMessage;
  LoginFailureState({required this.errMessage});
}