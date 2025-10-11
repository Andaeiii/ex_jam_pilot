import 'package:exjam_prj/views/pages/Comments.dart';
import 'package:exjam_prj/views/pages/profile_pg.dart';
import 'package:exjam_prj/views/pages/upload_img.dart';
import 'package:get/get.dart';
import '../views/pages/login.dart';
import '../views/pages/home.dart';
import '../views/pages/profile.dart';

const String appRouteDefault = "/login";
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: "/login", page: () => LoginPage()),
  GetPage(name: "/home", page: () => HomeScreen()),
  GetPage(name: "/comments", page: () => CommentsPage()),
  GetPage(name: "/photos", page: () => UploadImgs()),
  GetPage(name: "/profile", page: () => ProfilePage()),
  GetPage(name: "/test", page: () => InfluencerProfilePage()),
];
