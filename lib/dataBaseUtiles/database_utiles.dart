import 'package:chatapp/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/myuser.dart';

class DataBaseUtiles {

 static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance.collection(MyUser.CollectrionName)
        .withConverter<MyUser>(

      fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),);
  }
 static CollectionReference<Room> getRoomsCollection() {
   return FirebaseFirestore.instance.collection(Room.CollectrionName)
       .withConverter<Room>(
     fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
     toFirestore: (value, options) => value.toJson(),);
 }
 static Future<void> AddRoomToFireStore(Room room) {
   var collection = getRoomsCollection();
   var docRef = collection.doc();
   room.id = docRef.id;
  return docRef.set(room);
 }

 static Future<void> AddUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> ReadUserFromFireStore(String id) async {
    DocumentSnapshot<MyUser> user = await getUsersCollection().doc(id).get();
    var myuser = user.data();
    return myuser;
  }
}
