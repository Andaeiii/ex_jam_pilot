class InboxMessage {
  final int userId;
  final String firstName;
  final String lastName;
  final String message;
  final DateTime timeSent;
  final dynamic usrInfo;

  InboxMessage({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.message,
    this.usrInfo,
    required this.timeSent,
  });

  factory InboxMessage.fromJson(Map<String, dynamic> json) {
    return InboxMessage(
      userId: json['userId'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      message: json['message'] ?? '',
      usrInfo: json['userinfo'],
      timeSent: DateTime.tryParse(json['timeSent'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'message': message,
      'usrInfo': usrInfo,
      'timeSent': timeSent.toIso8601String(),
    };
  }
}
