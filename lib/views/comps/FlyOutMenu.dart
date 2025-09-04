import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class FlyOutMenu extends StatelessWidget {
  const FlyOutMenu({super.key});

  void goToPage(String page) {
    Get.offAllNamed(page);
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: Colors.blue,
      children: [
        SpeedDialChild(
          child: Icon(Icons.event_available_outlined),
          label: "Event",
          onTap: () {},
        ),
        SpeedDialChild(
          child: Icon(Icons.browse_gallery),
          label: "Photo(s)",
          onTap: () => goToPage('/photos'),
        ),
        SpeedDialChild(
          child: Icon(Icons.post_add),
          label: "Post",
          onTap: () {},
        ),
      ],
    );
  }
}
