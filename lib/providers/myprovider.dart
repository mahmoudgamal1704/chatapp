import 'package:chatapp/dataBaseUtiles/database_utiles.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  MyUser? myuser;
  late User? firebaseUser;

  MyProvider(){
    print('update user');
    firebaseUser = FirebaseAuth.instance.currentUser;
    print(firebaseUser?.email);
    if(firebaseUser !=null){
      initMyuser();
    }
    print(myuser?.email ?? 'fff');

  }

 void initMyuser () async{
    myuser = await  DataBaseUtiles.ReadUserFromFireStore(firebaseUser!.uid??"");
    print('${myuser!.email} ussssssssssssss');
  }
}