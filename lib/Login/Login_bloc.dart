
import 'package:bloc/bloc.dart';
import 'package:http/http.dart'as http;
import 'package:task_api/Login/Login_event.dart';
import 'package:task_api/Login/Login_state.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState>{

LoginBloc()  : super (LoginState()){
  on<NameChanged>(_onNameChanged);
  on<Emailchanged>(_onEmailChanged);
  on<Passwordchanged>(_onPasswordChanged);
  on<LoginApi>(loginApi);
  on<RegisterApi>(registerApi);

}
void _onNameChanged(NameChanged event,Emitter<LoginState>emit){

  emit(
    state.copyWith(
      name: event.name
    )
  );
}

void _onEmailChanged(Emailchanged event,Emitter<LoginState>emit){
  emit(
    state.copyWith(
      email: event.email,
    )
  );
}
void _onPasswordChanged(Passwordchanged event,Emitter<LoginState>emit){
  emit(
    state.copyWith(
      password: event.password,
    )
  );
}

void loginApi(LoginApi event, Emitter<LoginState> emit) async {
  emit(state.copyWith(loginStatus: LoginStatus.loading));

  Map<String, String> data = {
    'email': state.email.trim(),
    'password': state.password.trim(),
  };

  try {
    final response = await http.post(
      Uri.parse('https://driverapp.tyreoofoundation.org/api/login'),
      body: data, 
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(state.copyWith(
        loginStatus: LoginStatus.success,
        message: 'Login Successful',
      ));
      emit(state.copyWith(loginStatus: LoginStatus.initial));
    } else {
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        message: 'Invalid email or password',
      ));
      emit(state.copyWith(loginStatus: LoginStatus.initial));
    }
  } catch (e) {
    emit(state.copyWith(
      loginStatus: LoginStatus.error,
      message: e.toString(),
    ));
    emit(state.copyWith(loginStatus: LoginStatus.initial));
  }
}

void registerApi(RegisterApi event, Emitter<LoginState> emit) async {
  emit(state.copyWith(loginStatus: LoginStatus.loading));

  Map<String, String> data = {
    'name': state.name.trim(),
    'email': state.email.trim(),
    'password': state.password.trim(),
  };

  try {
    final response = await http.post(
      Uri.parse('https://driverapp.tyreoofoundation.org/api/register'),
      body: data, 
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      emit(state.copyWith(
        loginStatus: LoginStatus.success,
        message: 'Registration Successful',
      ));
      emit(state.copyWith(loginStatus: LoginStatus.initial));
    } else {
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        message: 'Registration Failed',
      ));
      emit(state.copyWith(loginStatus: LoginStatus.initial));
    }
  } catch (e) {
    emit(state.copyWith(
      loginStatus: LoginStatus.error,
      message: e.toString(),
    ));
    emit(state.copyWith(loginStatus: LoginStatus.initial));
  }
}
}