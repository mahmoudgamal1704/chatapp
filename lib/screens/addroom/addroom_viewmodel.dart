import 'package:chatapp/base.dart';
import 'package:chatapp/dataBaseUtiles/database_utiles.dart';
import 'package:chatapp/models/room.dart';
import 'package:chatapp/screens/addroom/addroom_navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void addRoomToDB(String title, String description, String categID) {
    navigator!.showLoading();
    Room room = Room(title: title, description: description, categID: categID);

    DataBaseUtiles.AddRoomToFireStore(room)
        .then((value) {
          navigator!.hideDialog();
          navigator!.showMessage('Room Added');
          print("Room Added");
    })
        .catchError((err) {
          print(err);
    });
  }
}
