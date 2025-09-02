import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ldx_controller.dart';

class LdxSpinner extends StatelessWidget {
  final Widget child;

  LdxSpinner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final loaderController = Get.find<LdxController>();

    return Stack(
      children: [
        child,
        Obx(() {
          if (loaderController.isLoading.value) {
            return Container(
              color: Color.fromRGBO(0, 0, 0, 0.298),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
