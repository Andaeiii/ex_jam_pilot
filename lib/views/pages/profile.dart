import 'dart:convert';

import 'package:exjam_prj/views/layouts/profile_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  final int userid;
  const ProfilePage({super.key, required this.userid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileController profileController;

  @override
  void initState() {
    super.initState();
    profileController = Get.put(ProfileController());
    profileController.fetchProfile(widget.userid);
  }

  void dispose() {
    Get.delete<ProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //return AppConfig.getDisplayImg(code, size: 20);
    return Obx(() {
      final p = profileController.profile.value;

      if (profileController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (profileController.errorMessage.isNotEmpty) {
        return Center(child: Text("Error: ${profileController.errorMessage}"));
      }

      if (profileController.profile.value == null) {
        return Center(child: Text("No profile data available"));
      }

      if (p == null) {
        return const Center(child: Text("No profile data available"));
      }

      var usrObj = p.usrInfo;

      return UserProfile(
        userId: p.userid,
        name: "${p.firstname} ${p.lastname}",
        email: "${usrObj['servnum']}, ${usrObj['squadron']} Squadron",
        bio: "${p.occupation}/${p.industry}",
        usrcode: usrObj['usrcode'],
        profilePix: p.hasDisplayImg,
        followers: 1240,
        following: 580,
        posts: 36,
        imageUrls: List.generate(
          9,
          (index) => "https://picsum.photos/id/${index + 30}/200/200",
        ),
      );
    });
  }
}
