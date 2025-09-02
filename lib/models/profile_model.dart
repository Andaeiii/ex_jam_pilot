import 'displayimg_model.dart';
import 'socials_model.dart'; 

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
  final DisplayImg displayImg;

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
    required this.displayImg,
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
      socials: Socials.fromJson(json['socials']),
      displayImg: DisplayImg.fromJson(json['display_img']),
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
      'display_img': displayImg.toJson(),
    };
  }
}
