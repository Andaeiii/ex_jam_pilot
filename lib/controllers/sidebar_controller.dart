import 'package:exjam_prj/controllers/base_controller.dart';
import 'package:get/get.dart';

class SidebarController extends BaseController {
  var isSidebarOpen = false.obs;
  var showOverlay = false.obs;

  void toggleSidebar() {
    isSidebarOpen.value = !isSidebarOpen.value;

    if (isSidebarOpen.value) {
      // Delay showing the overlay by 3 seconds
      Future.delayed(const Duration(milliseconds: 500), () {
        if (isSidebarOpen.value) showOverlay.value = true;
      });
    } else {
      showOverlay.value = false;
    }
  }
}
