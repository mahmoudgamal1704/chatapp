import 'package:chatapp/dataBaseUtiles/database_utiles.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  MyUser? myuser;
  late User? firebaseUser;

  MyProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser !=null){
      initMyuser();
    }

  }

  void initMyuser ()async {
    myuser = await DataBaseUtiles.ReadUserFromFireStore(firebaseUser!.uid??"");
  }
}