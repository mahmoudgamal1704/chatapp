import 'package:chatapp/base.dart';
import 'package:chatapp/dataBaseUtiles/database_utiles.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/screens/chat/chat_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/room.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  late MyUser myuser;
  List<Message> messages=[];
  void sendMessage(String content) {
    bool first = false;
    if (messages.length == 0) {
      print('0000000000000000');
      first = true;
    } else if (messages.length > 0) {
      var lastmessagedate = DateUtils.dateOnly(DateTime.fromMillisecondsSinceEpoch(messages[messages.length-1].dateTime)) ;
      var compare = DateUtils.dateOnly(DateTime.now()).compareTo(lastmessagedate);
      print(compare);
      if (compare == 0){
        first = false;
      }else  {
        first=true;
      }
    }
    Message message = Message(
        content: content,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        firstMessage: first,
        roomId: room.id,
        senderId: myuser.id,
        senderName: myuser.fName);
    DataBaseUtiles.addMessageToFireStore(message)
        .then((value) => navigator!.messageAdded());
  }

  Stream<QuerySnapshot<Message>> readMessages() {
    return DataBaseUtiles.readMessagesFromFireStore(room.id);
  }
}
