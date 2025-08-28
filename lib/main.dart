import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/login.dart';
import 'views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/home", page: () => HomeScreen()),
      ],
    );
  }
}
