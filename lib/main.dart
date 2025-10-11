import 'package:exjam_prj/utils/LifeCycleWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/auth_controller.dart';
import 'controllers/ldx_controller.dart';
import '../utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // ✅ Initialize GetStorage

  // Register lazily with fenix so it's recreated if disposed
  Get.lazyPut(() => AuthController(), fenix: true);

  runApp(LifeCycleCTRL(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      initialRoute: appRouteDefault,
      getPages: appRoutes,
      initialBinding: InitialBinding(), // ✅ Register controllers here
    );
  }
}

/// ✅ Binding for global controllers
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.put(LdxController());
  }
}
