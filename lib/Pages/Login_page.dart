


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_api/Login/Login_bloc.dart';
import 'package:task_api/Login/Login_event.dart';
import 'package:task_api/Login/Login_state.dart';
import 'package:task_api/Pages/Home_page.dart';
import 'package:task_api/Pages/Register_page.dart';
import 'package:task_api/Widgets/Icon_widget.dart';
import 'package:task_api/Widgets/Validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool _ispasswordvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'Login to your account',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  // Email Field
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) => current.email != previous.email,
                      builder: (context, state) {
                        return TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.validateEmail,
                          decoration: InputDecoration(
                            label: const Text('Email'),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.lightBlueAccent),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onChanged: (value) =>
                              context.read<LoginBloc>().add(Emailchanged(email: value)),
                        );
                      },
                    ),
                  ),
                  // Password Field
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) => current.password != previous.password,
                      builder: (context, state) {
                        return TextFormField(
                          controller: passwordcontroller,
                          obscureText: !_ispasswordvisible,
                          validator: Validators.validatePassword,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            hintText: 'Password',
                            suffixIcon: getvisibilityIcon(
                              isVisible: _ispasswordvisible,
                              onPressed: () {
                                setState(() {
                                  _ispasswordvisible = !_ispasswordvisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.lightBlueAccent),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onChanged: (value) =>
                              context.read<LoginBloc>().add(Passwordchanged(password: value)),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Login Button
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state.loginStatus == LoginStatus.error) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(content: Text(state.message.toString())));
                      }
                      if (state.loginStatus == LoginStatus.loading) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(const SnackBar(content: Text('Submitting')));
                      }
                      if (state.loginStatus == LoginStatus.success) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        onPressed: () {
                          context.read<LoginBloc>().add(LoginApi());
                        },
                        child: const Text('Login', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
              
                  // Register Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('You are new here?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text('Register Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        
      

    );
  }
  // Icon getpasswordicon(bool ispasswordvisible){
  //   if(ispasswordvisible){
  //     return Icon(Icons.visibility);
  //   }else{
  //     return Icon(Icons.visibility_off);
  //   }

  // }
}
