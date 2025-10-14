import 'package:exjam_prj/models/comment_model.dart';
import 'package:exjam_prj/utils/helpers/FormBtns.dart';
import 'package:exjam_prj/utils/helpers/FormCtrls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/comments_controller.dart';

class CommentsPage extends StatefulWidget {
  final int postId; //  receive post ID
  const CommentsPage({super.key, required this.postId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late CommentController commentController;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    commentController = Get.put(CommentController());
    commentController.fetchComments(widget.postId); // 👇 fetch comments
  }

  @override
  void dispose() {
    Get.delete<CommentController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comments")),
      body: Column(
        children: [
          // ✅ Comment Input Form
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, //top
              children: [
                Expanded(
                  child: FormCtrls.inputField(
                    controller: textController,
                    labelText: "Enter Comments",
                    icon: Icons.comment,
                    multiline: true,
                    minLines: 2,
                    maxLines: 5,
                  ),
                ),
                SizedBox(width: 3),
                FormBtns.fab(
                  icon: Icons.send,
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    commentController.addComment(
                      textController.text,
                      widget.postId,
                    );
                    textController.clear();
                  },
                ),
              ],
            ),
          ),

          // ✅ Comments List with GetX
          Expanded(
            child: Obx(() {
              if (commentController.comments.isEmpty) {
                return Center(child: Text("No comments yet. Be the first!"));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  // Simulate a refresh action
                  //await Future.delayed(Duration(seconds: 1));
                  commentController.fetchComments(widget.postId);
                },
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(), // refreshes always
                  itemCount: commentController.comments.length,
                  itemBuilder: (context, index) {
                    var comment = commentController.comments[index];
                    return commentItem(comment);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

Widget commentItem(Comment c) {
  print('Comment ID: ${c.id}, Content: ${c.content}');

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start, // 👈 aligns items to top
      children: [
        Stack(
          alignment: Alignment.center, // keeps the avatar centered
          children: [
            CircleAvatar(radius: 25, child: Icon(Icons.person)),
            Positioned(
              bottom: 2,
              left: 1,
              child: Icon(Icons.circle, size: 20, color: Colors.redAccent),
            ),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.fullname, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(c.content ?? '', style: TextStyle(fontSize: 14)),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    c.time ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    c.oldSquadron ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
