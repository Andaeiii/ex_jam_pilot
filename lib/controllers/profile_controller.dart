import 'package:exjam_prj/controllers/base_controller.dart';
import 'package:get/get.dart';
import '../models/Profile_model.dart';
import '../repos/profile_repository.dart';

class ProfileController extends BaseController {
  final ProfileRepository _profileRepo = ProfileRepository();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var profile = Rxn<Profile>(); //the fetched profile will be stored here...


  Future<void> fetchProfile(int userId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await _profileRepo.getUserProfile(userId);
      profile.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
