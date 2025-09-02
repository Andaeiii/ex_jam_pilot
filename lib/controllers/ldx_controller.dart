import 'package:get/get.dart';

class LdxController extends GetxController {
  var isLoading = false.obs;

  void show() => isLoading.value = true;
  void hide() => isLoading.value = false;
}
