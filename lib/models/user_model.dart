class UserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? bio;
  String? profileImage;
  String? coverImage;
  bool? isEmailVerified;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.isEmailVerified,
    this.profileImage,
    this.bio,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    phone = json['phone'];
    email = json['email']?.toString();
    uId = json['uId']?.toString();
    profileImage = json['image'];
    coverImage = json['coverImage'];
    isEmailVerified = json['emailVerification'];
    bio = json['bio']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['uId'] = uId;
    data['bio'] = bio;
    data['emailVerification'] = isEmailVerified;
    data['image'] = profileImage;
    data['coverImage'] = coverImage;
    return data;
  }
}
