class MessageModel {
  String? dateTime, receiverId, senderId, messageText;

  MessageModel(this.dateTime, this.receiverId, this.senderId, this.messageText);

  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    messageText = json['messageText'];
    senderId = json['senderId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'receiverId': receiverId,
      'messageText': messageText,
      'senderId': senderId,
    };
  }
}
