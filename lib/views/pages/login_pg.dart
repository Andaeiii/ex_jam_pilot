import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:exjam_prj/utils/helpers/FormCtrls.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwdController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -40,
                      height: 400,
                      width: width,
                      child: FadeInUp(
                        duration: Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/bg/background.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      height: 400,
                      width: width + 20,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/bg/background-2.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    FadeInUp(
                      duration: Duration(milliseconds: 1700),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Color.fromRGBO(196, 135, 198, .3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(196, 135, 198, .3),
                                  ),
                                ),
                              ),
                              child: FormCtrls.inputField(
                                controller: _emailController,
                                labelText: "Email / Service Number",
                                icon: Icons.email_outlined,
                                useBorder: false,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email or service number';
                                  }
                                  // Add additional validation if needed
                                  return null;
                                },
                                textColor: Colors.grey.shade700,
                                // Optional: add background color if desired
                                // backgroundColor: Colors.grey.shade100,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),

                              child: FormCtrls.inputField(
                                controller: _passwdController,
                                labelText: "Password",
                                icon: Icons.password_outlined,
                                useBorder: false,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password ';
                                  }
                                  // Add additional validation if needed
                                  return null;
                                },
                                textColor: Colors.grey.shade700,
                                // Optional: add background color if desired
                                // backgroundColor: Colors.grey.shade100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    FadeInUp(
                      duration: Duration(milliseconds: 1700),
                      child: Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color.fromRGBO(196, 135, 198, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    FadeInUp(
                      duration: Duration(milliseconds: 1900),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Color.fromRGBO(49, 39, 79, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    FadeInUp(
                      duration: Duration(milliseconds: 2000),
                      child: Center(
                        child: TextButton(
                          onPressed: _authController.isLoading.value
                              ? null
                              : () {
                                  _authController.login(
                                    _emailController.text.trim(),
                                    _passwdController.text.trim(),
                                  );
                                },
                          child: _authController.isLoading.value
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.blue,
                                  size: 30,
                                )
                              : Text(
                                  "Login Ex-Jam",
                                  style: TextStyle(
                                    color: Color.fromRGBO(49, 39, 79, .6),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
