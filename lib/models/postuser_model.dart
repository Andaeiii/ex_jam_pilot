class PostUser {
  final int id;
  final String firstname;
  final String? middlename;
  final String lastname;
  final bool display_img;
  final String usrcode;

  PostUser({
    required this.id,
    required this.firstname,
    this.middlename,
    required this.lastname,
    required this.display_img,
    required this.usrcode,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      id: json['id'],
      firstname: json["profile"]['firstname'],
      middlename: json["profile"]["middlename"],
      lastname: json["profile"]['lastname'],
      display_img: json["profile"]["display_img"] == 0 ? false : true,
      usrcode: json["profile"]["userinfo"]['usrcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'middlename': middlename,
      'lastname': lastname,
      'display_img': display_img,
      'usrcode': usrcode,
    };
  }
}
