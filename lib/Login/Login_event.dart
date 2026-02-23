



import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{

const LoginEvent();

@override
  List<Object> get props => [];
  }
  class NameChanged extends LoginEvent { 
  final String name;
  NameChanged({required this.name});
}


  class Emailchanged extends LoginEvent{
    const Emailchanged({required this.email});

    final String email;

    @override
  List<Object> get props => [];
  }

  class Passwordchanged extends LoginEvent{
    const Passwordchanged({required this.password});

    final String password;

    @override
  List<Object> get props => [];
  }

  class LoginApi extends LoginEvent{ }
  class RegisterApi extends LoginEvent {}

