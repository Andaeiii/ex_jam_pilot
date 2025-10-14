import 'package:exjam_prj/views/pages/Comments.dart';
import 'package:exjam_prj/views/pages/galleryPage.dart';
import 'package:exjam_prj/views/pages/upload_img.dart';
import 'package:get/get.dart';
import '../views/pages/login.dart';
import '../views/pages/home.dart';
import '../views/pages/profile.dart';

const String appRouteDefault = "/login";
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: "/login", page: () => LoginPage()),
  GetPage(name: "/home", page: () => HomeScreen()),

  GetPage(name: "/photos", page: () => UploadImgs()),
  GetPage(name: "/test", page: () => GalleryPage()),

  GetPage(
    name: '/comments/:postId',
    page: () {
      final postId = int.parse(Get.parameters['postId']!);
      return CommentsPage(postId: postId);
    },
  ),

  GetPage(
    name: '/profile/:userid',
    page: () {
      final uid = int.parse(Get.parameters['userid']!);
      return ProfilePage(userid: uid);
    },
  ),
];
