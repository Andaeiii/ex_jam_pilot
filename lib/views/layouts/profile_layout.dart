import 'package:exjam_prj/utils/helpers/AppConfig.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text('Profile'), centerTitle: true, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            AppConfig.getDisplayImg(usrcode, size: 80, hasDP: profilePix),

            SizedBox(height: 12),

            Text(
              name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              email,
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 48, 48, 48),
              ),
            ),
            SizedBox(height: 5),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 32, 31, 31),
                ),
              ),
            ),

            SizedBox(height: 20),

            // --- Stats Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem("Posts", posts),
                _buildStatItem("Followers", followers),
                _buildStatItem("Following", following),
              ],
            ),

            SizedBox(height: 25),
            Divider(thickness: 1),

            // --- Image Grid ---
            Padding(
              padding: EdgeInsets.all(12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: imageUrls.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(imageUrls[index], fit: BoxFit.cover),
                  );
                },
              ),
            ),
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
