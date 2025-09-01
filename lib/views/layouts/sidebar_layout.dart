import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/sidebar_menu.dart';
import '../../controllers/SidebarController.dart';
import '../../controllers/auth_controller.dart';

class SideBarLayout extends StatelessWidget {
  final SidebarController sidebarController = Get.put(SidebarController());
  final AuthController authController = Get.find<AuthController>();

  //layout properties...
  final String title;
  final Widget body;
  // final Widget? sidebar;

  SideBarLayout({
    super.key,
    required this.title,
    required this.body,
    //this.sidebar,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    //generate list...
    final years = List.generate(2020 - 1999 + 1, (index) => 1999 + index);

    return Scaffold(
      body: Stack(
        children: [
          // Main Page
          Obx(() {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              transform: Matrix4.translationValues(
                sidebarController.isSidebarOpen.value ? 0.7 * screenWidth : 0,
                0,
                0,
              ),
              curve: Curves.easeInOut,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  sidebarController.isSidebarOpen.value ? 20 : 0,
                ),
                child: Scaffold(
                  appBar: AppBar(
                    title: Obx(
                      () => sidebarController.isSidebarOpen.value
                          ? const SizedBox.shrink() // blank when sidebar open
                          : SizedBox(
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search Ex-Jams...",
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    leading: IconButton(
                      icon: Obx(
                        () => Icon(
                          sidebarController.isSidebarOpen.value
                              ? Icons.close
                              : Icons.menu,
                        ),
                      ),
                      onPressed: () {
                        sidebarController.toggleSidebar();
                      },
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          print("Add button tapped!");
                        },
                      ),
                    ],
                  ),

                  body: Container(
                    width: double.infinity,
                    height: double.infinity,
                    // color: Color.fromARGB(255, 225, 236, 241),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              color: const Color.fromARGB(255, 1, 20, 53),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Text(
                                'SETS',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: years.map((year) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color.fromARGB(
                                            255,
                                            149,
                                            206,
                                            216,
                                          ),
                                          width: 3,
                                        ),
                                        // gradient: LinearGradient(
                                        //   colors: [
                                        //     const Color.fromARGB(255, 255, 255, 255),
                                        //     const Color.fromARGB(255, 88, 165, 196),
                                        //   ],
                                        //   begin: Alignment.topCenter,
                                        //   end: Alignment.bottomCenter,
                                        // ),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 9,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 2,
                                      ),
                                      child: SizedBox(
                                        width: 60,
                                        height: 26,
                                        child: Text(
                                          '$year',
                                          style: TextStyle(fontSize: 16),
                                          textAlign:
                                              TextAlign.center, // optional
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Expanded(
                          flex: 1,
                          child: RefreshIndicator(
                            onRefresh: () {
                              return Future.delayed(Duration(seconds: 1));
                            },
                            child: body,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),

          // Sidebar
          SideBarMENU(
            sidebarController: sidebarController,
            screenWidth: screenWidth,
            authController: authController,
          ),

          // Dimmed overlay when sidebar is open // to close sidebar on tap
          Obx(() {
            return sidebarController.isSidebarOpen.value
                ? Positioned(
                    left: 0.7 * screenWidth,
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        sidebarController.toggleSidebar();
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.3), // Dimmed effect
                      ),
                    ),
                  )
                : SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
