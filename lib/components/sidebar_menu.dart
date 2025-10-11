import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sidebar_controller.dart';
import '../controllers/auth_controller.dart';

class SideBarMENU extends StatelessWidget {
  const SideBarMENU({
    super.key,
    required this.sidebarController,
    required this.screenWidth,
    required this.authController,
  });

  final SidebarController sidebarController;
  final double screenWidth;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        top: 0,
        bottom: 0,
        left: sidebarController.isSidebarOpen.value ? 0 : -0.7 * screenWidth,
        child: SizedBox(
          width: 0.7 * screenWidth,
          child: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  // decoration: BoxDecoration(
                  //   color: const Color.fromARGB(
                  //     255,
                  //     3,
                  //     40,
                  //     71,
                  //   ), // optional background color
                  //   border: BoxBorder.all(color: Colors.blueAccent, width: 2),
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40, // size of avatar
                        backgroundImage: AssetImage(
                          "assets/images/avatar.jpg",
                        ), // local image
                        // backgroundImage: NetworkImage("https://i.pravatar.cc/150"), // network
                      ),
                      SizedBox(height: 10),
                      Text(
                        authController.user.value?.email ?? "Un-named exjam",
                        style: TextStyle(
                          color: Color.fromARGB(255, 2, 23, 211),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "johndoe@email.com",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {},
                ),

                // Align menu items to the bottom
                _buildMenuItem(Icons.person, 'My Profile', () {}),
                _buildMenuItem(Icons.settings, 'Settings', () {}),
                SizedBox(height: 40),
                _buildMenuItem(Icons.logout, 'Logout', () {
                  authController.logout();
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
  return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
}
