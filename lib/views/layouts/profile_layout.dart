import 'package:exjam_prj/controllers/profile_layout_controller.dart';
import 'package:exjam_prj/utils/helpers/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../imgComps/SlideShowPg.dart';

class UserProfile extends StatefulWidget {
  final int userId;
  final String name;
  final String email;
  final String bio;
  final String usrcode;
  final int followers;
  final int following;
  final int posts;
  final bool profilePix;
  final List<String> imageUrls;

  UserProfile({
    super.key,
    required this.userId,
    required this.name,
    required this.email,
    required this.bio,
    required this.usrcode,
    required this.followers,
    required this.following,
    required this.posts,
    required this.profilePix, //true or false...
    required this.imageUrls,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late final UserProfileController controller;

  final List<String> btnLabels = ['inbox', 'photos', 'Posts'];

  @override
  void initState() {
    super.initState();
    controller = Get.put(UserProfileController());
    controller.buildProfileTabs();
  }

  @override
  void dispose() {
    Get.delete<UserProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Ex-Jam Profile'),
        // centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            AppConfig.getDisplayImg(
              widget.usrcode,
              size: 80,
              hasDP: widget.profilePix,
            ),

            SizedBox(height: 12),

            Text(
              widget.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 48, 48, 48),
              ),
            ),
            SizedBox(height: 5),

            AppConfig.mkStatusMsg(widget.bio),

            SizedBox(height: 20),

            // --- Stats Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem("Posts", widget.posts),
                _buildStatItem("Followers", widget.followers),
                _buildStatItem("Following", widget.following),
              ],
            ),

            SizedBox(height: 15),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: btnLabels.asMap().entries.map((entry) {
                  final index = entry.key;
                  final label = entry.value;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 4,
                        right: index == btnLabels.length - 1 ? 0 : 0,
                      ),
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            controller.setCurItem(index);
                            print('Selected: ${controller.curIndex.value}');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.curIndex.value == index
                                ? Colors.blue
                                : const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ), // smaller height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 14,
                              color: controller.curIndex.value == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // --- Image Grid ---

            // 📦 Reactive Section Content
            Obx(() {
              final index = controller.curIndex.value;

              switch (index) {
                case 0:
                  return InboxSection(uid: widget.userId);

                case 1:
                  return PhotosSection(imageUrls: widget.imageUrls);

                case 2:
                  return PostsSection();

                default:
                  return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(
          "$value",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}

/////////////////////////////////////////////the inbox widget definitionss...............

class InboxSection extends StatefulWidget {
  final int uid;
  const InboxSection({super.key, required this.uid});

  @override
  State<InboxSection> createState() => _InboxSectionState();
}

class _InboxSectionState extends State<InboxSection> {
  late UserProfileController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<UserProfileController>();
    controller.getUsersInbox();
  }

  @override
  void dispose() {
    Get.delete<UserProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.orange.shade100,
      alignment: Alignment.center,
      child: Text('📩 Inbox Section ${widget.uid}'),
    );
  }
}

class PhotosSection extends StatelessWidget {
  final List<String> imageUrls;
  const PhotosSection({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: imageUrls.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // 👇 Navigate to the slideshow gallery
                  Get.to(
                    () => SlideshowGallery(
                      photos: imageUrls,
                      initialIndex: index,
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imageUrls[index], fit: BoxFit.cover),
                ),
              );
            },
          ),

          SizedBox(height: 5),
          Divider(thickness: 0.5, color: Color.fromARGB(255, 255, 255, 255)),
          AppConfig.mkStatusMsg('${imageUrls.length} photos only....'),
        ],
      ),
    );
  }
}

class PostsSection extends StatelessWidget {
  const PostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blue.shade100,
      alignment: Alignment.center,
      child: Text('📝 Posts Section'),
    );
  }
}
