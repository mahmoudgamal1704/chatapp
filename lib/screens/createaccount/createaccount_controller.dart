import 'package:chatapp/base.dart';
import 'package:chatapp/models/myuser.dart';

abstract class CreateAccountNavigator extends BaseNavigator{

  void goToHome(MyUser myuser);

}