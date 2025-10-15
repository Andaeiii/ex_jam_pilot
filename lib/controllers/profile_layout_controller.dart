import 'package:exjam_prj/controllers/base_controller.dart';
import 'package:get/get.dart';

import '../models/inbox_message.dart';

class UserProfileController extends BaseController {
  var curIndex = 0.obs;

  var inboxMessages = <InboxMessage>[].obs; //array of InboMessage items....
  var isLoadingInbox = false.obs;

  void setCurItem(int id) {
    curIndex.value = id;
  }

  void buildProfileTabs() {
    print('getting all the items....');
  }

  Future<List<InboxMessage>> getUsersInbox() async {
    isLoadingInbox.value = true;

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 5));

    // Generate 10 dummy inbox items
    final messages = List.generate(10, (index) {
      return InboxMessage(
        userId: index + 1,
        firstName: 'User$index',
        lastName: 'Lastname$index',
        message: 'Hey there! This is message #$index',
        timeSent: DateTime.now().subtract(Duration(minutes: index * 5)),
      );
    });

    inboxMessages.assignAll(messages);
    isLoadingInbox.value = false;
    return messages;
  }
}
