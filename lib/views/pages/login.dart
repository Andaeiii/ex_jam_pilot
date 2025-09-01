import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Email
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Error message
                if (_authController.errorMessage.isNotEmpty)
                  Text(
                    _authController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 16),

                // Login button
                ElevatedButton(
                  onPressed: _authController.isLoading.value
                      ? null
                      : () {
                          _authController.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        },
                  child: _authController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Login"),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
