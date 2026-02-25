import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_api/Login/Login_bloc.dart';
import 'package:task_api/Login/Login_event.dart';
import 'package:task_api/Login/Login_state.dart';
import 'package:task_api/Pages/Login_page.dart';
import 'package:task_api/Widgets/Icon_widget.dart';
import 'package:task_api/Widgets/Validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  bool _ispasswordvisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                'Register your account',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 40.h),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      current.name != previous.name,
                  builder: (context, state) {
                    return TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        label: const Text('Name'),
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<LoginBloc>().add(NameChanged(name: value));
                      },
                      validator: (value) => value == null || value.isEmpty
                          ? 'Name required'
                          : null,
                    );
                  },
                ),
              ),

              /// Email Field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      current.email != previous.email,
                  builder: (context, state) {
                    return TextFormField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<LoginBloc>().add(
                          Emailchanged(email: value),
                        );
                      },
                      validator: Validators.validateEmail,
                    );
                  },
                ),
              ),

              /// Password Field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      current.password != previous.password,
                  builder: (context, state) {
                    return TextFormField(
                      controller: passwordcontroller,
                      obscureText: !_ispasswordvisible,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        suffixIcon: getvisibilityIcon(
                          isVisible: _ispasswordvisible,
                          onPressed: () {
                            setState(() {
                              _ispasswordvisible = !_ispasswordvisible;
                            });
                          },
                        ),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<LoginBloc>().add(
                          Passwordchanged(password: value),
                        );
                      },
                      validator: Validators.validatePassword,
                    );
                  },
                ),
              ),

              SizedBox(height: 50.h),

              /// Register Button with BlocListener
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.loginStatus == LoginStatus.error) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text(state.message.toString())),
                      );
                  }

                  if (state.loginStatus == LoginStatus.success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            context.read<LoginBloc>().add(RegisterApi());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// Navigate to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Registered?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text('Login Now'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
