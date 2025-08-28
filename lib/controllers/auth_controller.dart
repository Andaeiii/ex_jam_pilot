import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repos/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  var isLoading = false.obs;
  var errorMessage = "".obs;
  var token = "".obs;

  // ✅ Keep user stored
  var user = Rxn<UserModel>();

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final result = await _authRepository.login(email, password);

      // ✅ Save token and user
      token.value = result["token"];
      user.value = result["user"];

      print("Login Success: ${user.value?.email}"); // debug log

      // Navigate to Home on success
      Get.offAllNamed("/home");
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
