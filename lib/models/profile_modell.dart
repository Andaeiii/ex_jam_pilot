import 'socials_model.dart';
import 'dart:convert';

class Profile {
  final int id;
  final String firstname;
  final String? middlename;
  final String lastname;
  final String nickname;
  final String occupation;
  final String industry;
  final bool jobSeeker;
  final String skills;
  final Socials socials;
  final bool hasDisplayImg;

  final dynamic usrInfo;

  Profile({
    required this.id,
    required this.firstname,
    this.middlename,
    required this.lastname,
    required this.nickname,
    required this.occupation,
    required this.industry,
    required this.jobSeeker,
    required this.skills,
    required this.socials,
    required this.hasDisplayImg,

    this.usrInfo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      firstname: json['firstname'],
      middlename: json['middlename'],
      lastname: json['lastname'],
      nickname: json['nickname'],
      occupation: json['occupation'],
      industry: json['industry'],
      jobSeeker: json['job_seeker'] == 1,
      skills: json['skills'],

      // 👇 decode string to map if needed
      socials: json['socials'] is String
          ? Socials.fromJson(jsonDecode(json['socials']))
          : Socials.fromJson(json['socials']),

      hasDisplayImg: json['display_img'] == 1 ? true : false,

      usrInfo: json['userinfo'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'middlename': middlename,
      'lastname': lastname,
      'nickname': nickname,
      'occupation': occupation,
      'industry': industry,
      'job_seeker': jobSeeker ? 1 : 0,
      'skills': skills,
      'socials': socials.toJson(),
      'hasDisplayImg': hasDisplayImg,

      'usrinfo': usrInfo,
    };
  }
}
