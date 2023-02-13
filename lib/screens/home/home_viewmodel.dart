import 'package:chatapp/base.dart';
import 'package:chatapp/dataBaseUtiles/database_utiles.dart';
import 'package:chatapp/screens/home/home_navigator.dart';

import '../../models/room.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void readRooms() {
    DataBaseUtiles.ReadRoomFireStore().then((value) {
      rooms = value;
    }).catchError((onError) {
      navigator!.showMessage(onError.toString());
    });

  }
}
