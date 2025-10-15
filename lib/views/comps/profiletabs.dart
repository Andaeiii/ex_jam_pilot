import 'package:flutter/material.dart';

class ProfileTabPage extends StatelessWidget {
  const ProfileTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile Page'), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 🧑‍🦱 Avatar
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=3',
                ),
              ),
              const SizedBox(height: 20),

              // 🧭 Tabs
              const TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: 'Messages'),
                  Tab(text: 'Gallery'),
                  Tab(text: 'Posts'),
                ],
              ),

              // 📄 Tab content area
              Expanded(
                child: TabBarView(
                  children: [
                    // Messages Tab
                    Center(
                      child: Text(
                        '📬 Inbox Messages',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                    // Gallery Tab
                    GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://picsum.photos/200?image=${index + 10}',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),

                    // Posts Tab
                    ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: 5,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text('Post ${index + 1}'),
                          subtitle: const Text(
                            'This is a simple post example.',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
