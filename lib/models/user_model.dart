class User {
  final int id;
  final String email;
  final int? squadronId;
  final String servNum;
  final String usrcode;
  final DateTime? emailVerifiedAt;
  final String? rememberToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    this.squadronId,
    required this.servNum,
    required this.usrcode,
    this.emailVerifiedAt,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  /// Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      squadronId: json['squadron_id'],
      servNum: json['serv_num'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.tryParse(json['email_verified_at'])
          : null,
      usrcode: json['hashcode'],
      rememberToken: json['remember_token'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  /// Convert User back to JSON (for sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'squadron_id': squadronId,
      'serv_num': servNum,
      'usrcode': usrcode,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'remember_token': rememberToken,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
