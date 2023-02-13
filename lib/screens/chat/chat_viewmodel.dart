import 'package:chatapp/base.dart';
import 'package:chatapp/dataBaseUtiles/database_utiles.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/screens/chat/chat_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/room.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
late Room room;
late MyUser myuser;
  void sendMessage(String content) {
    Message message = Message(
        content: content,
        dateTime: DateTime.now().microsecondsSinceEpoch.toString(),
        roomId: room.id,
        senderId: myuser.id,
        senderName: myuser.fName);
    DataBaseUtiles.addMessageToFireStore(message).then((value) => navigator!.messageAdded());
  }

  Stream<QuerySnapshot<Message>> readMessages(){
    return DataBaseUtiles.readMessagesFromFireStore(room.id);
  }


}