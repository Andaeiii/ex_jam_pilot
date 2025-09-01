import 'package:get/get.dart';
import '../views/pages/login.dart';
import '../views/pages/home.dart';
import '../views/pages/social_wall.dart';

const String appRouteDefault = "/login";
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: "/login", page: () => LoginScreen()),
  GetPage(name: "/home", page: () => HomeScreen()),
  GetPage(name: "/test", page: () => SocialWallPage()),
];
