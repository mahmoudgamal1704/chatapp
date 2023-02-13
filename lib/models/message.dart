class Message {

  static String CollectrionName='Message';
  String id;
  String content;
  bool firstMessage;
  int dateTime;
  String roomId;
  String senderId;
  String senderName;

  Message({this.id = "",
    required this.content,
    this.firstMessage = false,
    required this.dateTime,
    required this.roomId,
    required this.senderId,
    required this.senderName});

  Message.fromJson(Map<String, dynamic> json) :this (
    id: json["id"],
    content: json["content"],
    firstMessage: json["firstMessage"],
    dateTime: json["dateTime"],
    roomId: json["roomId"],
    senderId: json["senderId"],
    senderName: json["senderName"],
  );

 Map<String,dynamic> toJson(){
    return {
      "id":id,
      "content":content,
      "firstMessage":firstMessage,
      "dateTime":dateTime,
      "roomId":roomId,
      "senderId":senderId,
      "senderName":senderName,
    };
  }
}
