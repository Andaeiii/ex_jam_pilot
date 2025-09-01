import 'package:exjam_prj/views/layouts/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'social_wall.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SideBarLayout(title: "HomePage", body: SocialWallPage());
  }
}
