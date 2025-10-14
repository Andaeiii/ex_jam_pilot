import 'package:exjam_prj/controllers/base_controller.dart';
import 'package:get/get.dart';

class LdxController extends BaseController {
  var isLoading = false.obs;

  void show() => isLoading.value = true;
  void hide() => isLoading.value = false;
}
