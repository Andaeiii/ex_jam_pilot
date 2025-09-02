class DisplayImg {
  final bool changed;
  final String imgfile;

  DisplayImg({required this.changed, required this.imgfile});

  factory DisplayImg.fromJson(Map<String, dynamic> json) {
    return DisplayImg(changed: json['changed'], imgfile: json['imgfile']);
  }

  Map<String, dynamic> toJson() {
    return {'changed': changed, 'imgfile': imgfile};
  }
}
