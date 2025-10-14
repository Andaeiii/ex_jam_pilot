class Socials {
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedin;

  Socials({
     this.facebook,
     this.twitter,
     this.instagram,
     this.linkedin,
  });

  factory Socials.fromJson(Map<String, dynamic> json) {
    return Socials(
      facebook: json['facebook'],
      twitter: json['twitter'],
      instagram: json['instagram'],
      linkedin: json['linkedin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'linkedin': linkedin,
    };
  }
}
