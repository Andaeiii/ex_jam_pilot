import 'package:get/get.dart';
import '../views/login.dart';
import '../views/home.dart';

const String appRouteDefault = "/login";
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: "/login", page: () => LoginScreen()),
  GetPage(name: "/home", page: () => HomeScreen()),
];
