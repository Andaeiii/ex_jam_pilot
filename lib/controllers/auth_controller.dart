import 'package:exjam_prj/controllers/base_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import '../repos/auth_repository.dart';

class AuthController extends BaseController {
  final AuthRepository _authRepository = AuthRepository();
  final storage = GetStorage(); // ✅ Storage instance

  var isLoading = false.obs;
  var errorMessage = "".obs;
  var token = "".obs;

  // ✅ Keep user stored
  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    // ✅ Auto-load token if it exists
    String? savedToken = storage.read("token");
    if (savedToken != null) {
      token.value = savedToken;
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
      storage.write('userId', user.value?.id);

      //persist the user and profile data also...
      storage.write('usrcode', user.value?.toJson());

      Get.offAllNamed("/home");
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    token.value = "";
    user.value = null;
    storage.remove("token"); // ✅ Clear token
    //Get.deleteAll();
    Get.offAllNamed("/login");
    //Get.offAll(() => LoginPage());
  }
}
