import 'package:get/get.dart';
import '../view_comps/wallposts.dart';
import '../views/login.dart';
import '../views/home.dart';
import '../views/social_wall.dart';

const String appRouteDefault = "/login";
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: "/login", page: () => LoginScreen()),
  GetPage(name: "/home", page: () => HomeScreen()),
  GetPage(name: "/test", page: () => SocialWallPage()),
  GetPage(name: "/test2", page: () => WallPage()),
];
