class Message {

  static String CollectrionName='Message';
  String id;
  String content;
  String dateTime;
  String roomId;
  String senderId;
  String senderName;

  Message({this.id = "",
    required this.content,
    required this.dateTime,
    required this.roomId,
    required this.senderId,
    required this.senderName});

  Message.fromJson(Map<String, dynamic> json) :this (
    id: json["id"],
    content: json["content"],
    dateTime: json["dateTime"],
    roomId: json["roomId"],
    senderId: json["senderId"],
    senderName: json["senderName"],
  );

 Map<String,dynamic> toJson(){
    return {
      "id":id,
      "content":content,
      "dateTime":dateTime,
      "roomId":roomId,
      "senderId":senderId,
      "senderName":senderName,
    };
  }
}
