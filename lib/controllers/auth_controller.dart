import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import '../repos/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final storage = GetStorage(); // ✅ Storage instance

  var isLoading = false.obs;
  var errorMessage = "".obs;
  var token = "".obs;

  // ✅ Keep user stored
  var user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();

    // ✅ Auto-load token if it exists
    String? savedToken = storage.read("token");
    if (savedToken != null) {
      token.value = savedToken;
      print("Loaded token from storage: $savedToken");
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final result = await _authRepository.login(email, password);

      // ✅ Save token and user
      token.value = result["token"];
      user.value = result["user"];

      // ✅ Persist token
      storage.write("token", token.value);

      print("Login Success: ${user.value?.email}");

      Get.offAllNamed("/home");
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authRepository.logout();
    } catch (e) {
      // API error not critical, just clear token anyway
      print("Logout error: $e");
    } finally {
      // ✅ Always clear token
      storage.remove("token");
      user.value = null;

      //log out and go back to login screen....
      Get.offAllNamed("/login");
      isLoading.value = false;
    }
  }

  // void logout() {
  //   token.value = "";
  //   user.value = null;
  //   storage.remove("token"); // ✅ Clear token
  //   Get.offAllNamed("/login");
  // }
}
