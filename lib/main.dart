import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_api/Login/Login_bloc.dart';
import 'package:task_api/Pages/Login_page.dart';
import 'package:task_api/Pages/Register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(439, 932),
      minTextAdapt: true,
      splitScreenMode: true, // handles landscape / multi-window
      builder: (context, child) {
        return BlocProvider(
          create: (_) => LoginBloc(), // Provide LoginBloc to the entire app
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/login',
            routes: {
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
            },
          ),
        );
      },
    );
  }
}
