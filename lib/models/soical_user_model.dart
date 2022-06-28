class SocialUserModel {
  late String name;
  late String image;
  String? cover;
  String? email;
  String? bio;
  String? phone;
  dynamic uid;
  bool? isEmailVerified = false;
  SocialUserModel({
    required this.name,
    required this.image,
    this.cover,
    this.email,
    this.bio,
    this.phone,
    this.uid,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    phone = json['phone'];
    uid = json['uid'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'cover': cover,
      'bio': bio,
      'phone': phone,
      'uid': uid,
      'isEmailVerified': isEmailVerified,
    };
  }
}
