import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/message.dart';
import '../providers/myprovider.dart';

class MessageWidget extends StatelessWidget {
  // const MessageWidget({Key? key}) : super(key: key);
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProvider>(context);

    return prov.myuser!.id == message.senderId
        ? SenderMessage(message)
        : ReciveMessage(message);
  }
}

class SenderMessage extends StatelessWidget {
  // const SenderMessage({Key? key}) : super(key: key);
  Message message;

  SenderMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int datemill = int.parse(message.dateTime);
    var dt = DateTime.fromMillisecondsSinceEpoch(datemill);
    var date=DateFormat("hh:mm a").format(dt);
    return Container(
margin: EdgeInsets.only(right: 10,top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Text(message.content,style: TextStyle(color: Colors.white),),

          ),
          Text(date),
        ],
      ),
    );
  }
}

class ReciveMessage extends StatelessWidget {
  // const ReciveMessage({Key? key}) : super(key: key);
  Message message;

  ReciveMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int datemill = int.parse(message.dateTime);
    var dt = DateTime.fromMillisecondsSinceEpoch(datemill);
    var date=DateFormat("hh:mm a").format(dt);
    return Container(
      margin: EdgeInsets.only(right: 10,top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: Text(message.content),

          ),
          Text(date),
        ],
      ),
    );
  }
}
