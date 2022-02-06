class UserModel {
  String? name;
  int? phone;
  String? email;
  String? uId;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    phone = json['phone']?.toInt();
    email = json['email']?.toString();
    uId = json['uId']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['uId'] = uId;
    return data;
  }
}
