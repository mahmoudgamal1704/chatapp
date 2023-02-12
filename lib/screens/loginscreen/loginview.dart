import 'package:chatapp/base.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/screens/createaccount/create_account.dart';
import 'package:chatapp/screens/loginscreen/loginnavigator.dart';
import 'package:chatapp/screens/loginscreen/loginviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/myprovider.dart';
import '../home/home_view.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/main_bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text("Login"),
              ),
              body: Form(
                key: frmKey,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.trim() == "") {
                            return "Please Enter Your Email Addrees";
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return "Please Enter Valid Email Addrees";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email Address",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passController,
                        validator: (value) {
                          if (value!.trim() == "") {
                            return "Please Enter Your Password";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            ValidateForm();
                          },
                          child: Text("Login")),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, CreateAccountScreen.routeName);
                          }, child: Text("Dont Have Account"))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Future<void> ValidateForm() async {
    if (frmKey.currentState!.validate()) {
      viewModel.LoginAccountwithFireBaseAuth(
          emailController.text, passController.text);
    }
  }

  @override
  LoginViewModel initViewModel() {
    // TODO: implement initViewModel
    return LoginViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    // TODO: implement goToHome
    var provider = Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName,
        arguments: myUser);
  }
}
