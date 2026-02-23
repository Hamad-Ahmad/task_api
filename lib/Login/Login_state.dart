


import 'package:equatable/equatable.dart';

enum LoginStatus{initial,loading,success,error}

class LoginState extends Equatable{
  const LoginState({this.name='',this.email='',this.password='',this.message='',this.loginStatus= LoginStatus.initial});
final String name;
final String email;
final String password;
final String message;
final LoginStatus loginStatus;


LoginState copyWith({
String? name,
String? email,
String? password,
String? message,
LoginStatus? loginStatus,

}){

  return LoginState(
    name: name?? this.email,
    email: email ?? this.email,
    password: password ?? this.password,
    message: message ?? this.message,
    loginStatus: loginStatus ?? this.loginStatus
  );
}

  @override
  List<Object?> get props => [email,password,message,loginStatus];
}