import 'package:chatapp/dataBaseUtiles/database_utiles.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/screens/loginscreen/loginnavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../base.dart';
import '../../shared/items/firebase_errors.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  String message = "";

  Future<void> LoginAccountwithFireBaseAuth(String email, String pass) async {
    try {
      navigator!.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      message = "Login Succfully";
// Read user data from db
      MyUser? myUser = await DataBaseUtiles.ReadUserFromFireStore(
          credential.user?.uid ?? "");
      if (myUser != null) {
        // go to home
        navigator!.hideDialog();
        navigator!.goToHome(myUser);
        return;
      }
    } on FirebaseAuthException catch (e) {
      message = "Email Or Password is Wrong";
    } catch (e) {
      message = "SomeThing went Wrong : ${e.toString()}";
      print(e);
    }
    if (message != "") {
      navigator!.hideDialog();
      navigator!.showMessage("${message}");
    }
  }
}
