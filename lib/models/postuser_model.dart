class PostUser {
  final int id;
  final String firstname;
  final String? middlename;
  final String lastname;
  final String avatar;

  PostUser({
    required this.id,
    required this.firstname,
    this.middlename,
    required this.lastname,
    required this.avatar,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      id: json['id'],
      firstname: json["profile"]['firstname'],
      middlename: json["profile"]["middlename"],
      lastname: json["profile"]['lastname'],
      avatar: json["profile"]["display_img"]["imgfile"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'middlename': middlename,
      'lastname': lastname,
      'avatar': avatar,
    };
  }
}
