import 'package:chatapp/base.dart';
import 'package:chatapp/dataBaseUtiles/database_utiles.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/screens/createaccount/createaccount_controller.dart';
import 'package:chatapp/shared/items/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountViewModel extends BaseViewModel<CreateAccountNavigator> {
  Future<void> CreateAccountwithFireBaseAuth(
      String fName, String userName, String email, String pass) async {
    try {
      navigator!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      navigator!.hideDialog();
      navigator!.showMessage("Account Created Succfully");
// ad user data to db
      MyUser myUser = MyUser(
          id: credential.user?.uid ?? "",
          fName: fName,
          userName: userName,
          email: email);
      DataBaseUtiles.AddUserToFireStore(myUser).then((value) {
        //go to home
        navigator!.goToHome(myUser);
      });
      
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrors.weakPass) {
        navigator!.hideDialog();
        navigator!.showMessage("The password provided is too weak.");
        // print('The password provided is too weak.');
      } else if (e.code == FireBaseErrors.emailInUse) {
        navigator!.hideDialog();
        navigator!.showMessage("The account already exists for that email.");
        // print('The account already exists for that email.');
      }
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage("${e.toString()}");
      print(e);
    }
  }
}
