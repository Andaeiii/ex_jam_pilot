import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditMode = false;
  int _expandedIndex = -1;

  // Dummy profile data
  String _name = "John Doe";
  String _email = "john.doe@example.com";
  String _bio = "Flutter developer and tech enthusiast.";

  // Controllers for edit mode
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _name);
    _emailController = TextEditingController(text: _email);
    _bioController = TextEditingController(text: _bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            'https://www.w3schools.com/howto/img_avatar.png',
          ),
        ),
        const SizedBox(height: 16),
        _isEditMode
            ? TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
              )
            : Text(
                _name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
        const SizedBox(height: 8),
        _isEditMode
            ? TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
              )
            : Text(_email, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        _isEditMode
            ? TextField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: "Bio"),
              )
            : Text(_bio),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (_isEditMode) {
                // Save changes
                _name = _nameController.text;
                _email = _emailController.text;
                _bio = _bioController.text;
              }
              _isEditMode = !_isEditMode;
            });
          },
          child: Text(_isEditMode ? "Update Profile" : "Edit Profile"),
        ),
      ],
    );
  }

  Widget _buildAccordionMenu() {
    final List<Map<String, dynamic>> items = [
      {
        "icon": Icons.lock,
        "title": "Privacy",
        "content": "Manage privacy and security settings.",
      },
      {
        "icon": Icons.notifications,
        "title": "Notifications",
        "content": "Set your notification preferences.",
      },
      {
        "icon": Icons.help,
        "title": "Help & Support",
        "content": "FAQ and support information.",
      },
      {
        "icon": Icons.info,
        "title": "About",
        "content": "App version 1.0.0 — Built with Flutter 💙",
      },
    ];

    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _expandedIndex = isExpanded ? -1 : index; // only one open at a time
        });
      },
      animationDuration: const Duration(milliseconds: 400),
      children: List.generate(items.length, (index) {
        final item = items[index];
        return ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return ListTile(
              leading: Icon(item["icon"]),
              title: Text(item["title"]),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(item["content"]),
          ),
          isExpanded: _expandedIndex == index,
          canTapOnHeader: true,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Page"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildAccordionMenu(),
          ],
        ),
      ),
    );
  }
}
