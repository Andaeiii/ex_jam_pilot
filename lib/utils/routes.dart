import 'package:exjam_prj/views/pages/Comments.dart';
import 'package:get/get.dart';
import '../views/pages/login.dart';
import '../views/pages/home.dart';

const String appRouteDefault = "/test";
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: "/login", page: () => LoginScreen()),
  GetPage(name: "/home", page: () => HomeScreen()),
  GetPage(name: "/test", page: () => CommentsPage()),
];
