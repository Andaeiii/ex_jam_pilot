import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          TextButton.icon(
            onPressed: () {
              authController.logout();
            },
            icon: Icon(Icons.logout),
            label: Text("Logout"),
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          final user = authController.user.value;
          return user == null
              ? const Text("No user logged in")
              : Text("Welcome, ${user.name}");
        }),
      ),
    );
  }
}
