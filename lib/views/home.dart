import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = _authController.user.value;

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome, ${user.name}!",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Email: ${user.email}"),
                  const SizedBox(height: 20),
                  Text("Token: ${_authController.token.value}"),
                ],
              )
            : const Text("No user data available"),
      ),
    );
  }
}
