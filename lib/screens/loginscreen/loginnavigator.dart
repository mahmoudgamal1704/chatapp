import 'package:chatapp/base.dart';
import 'package:chatapp/models/myuser.dart';

abstract class LoginNavigator extends BaseNavigator {

  void goToHome(MyUser myUser);
}