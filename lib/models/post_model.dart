class PostModel {
  String? name, uId, userImage, text, postImage, dateTime;

  PostModel(
    this.name,
    this.uId,
    this.userImage,
    this.text,
    this.postImage,
    this.dateTime,
  );

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    userImage = json['userImage'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['name'] = name;
    json['uId'] = uId;
    json['userImage'] = userImage;
    json['text'] = text;
    json['postImage'] = postImage;
    json['dateTime'] = dateTime;

    return json;
  }

  // 2nd Way to make toJson Method
  Map<String, dynamic> toJson2() {
    return {
      'name': name,
      'userImage': userImage,
      'text': text,
      'uId': uId,
      'postImage': postImage,
      'dateTime': dateTime,
    };
  }
}
