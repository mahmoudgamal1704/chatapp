import 'package:chatapp/screens/chat/chat_view.dart';
import 'package:flutter/material.dart';

import '../models/room.dart';

class RoomWidget extends StatelessWidget {
Room room;

RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //
        Navigator.pushNamed(context, ChatScreen.routeName,arguments: room);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        // height: MediaQuery.of(context).size.height*.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ) ,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/images/${room.categID}.png',
                width: MediaQuery.of(context).size.height*.25,
                fit: BoxFit.fitWidth,
                )),
            SizedBox(height: 10,),
            Text('${room.title}'),
          ],
        ),
      ),
    );
  }
}
