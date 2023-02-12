import 'package:chatapp/base.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/screens/createaccount/create_account_viewmodel.dart';
import 'package:chatapp/screens/createaccount/createaccount_controller.dart';
import 'package:chatapp/screens/home/home_view.dart';
import 'package:chatapp/screens/loginscreen/loginview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/myprovider.dart';

class CreateAccountScreen extends StatefulWidget {
  // const CreateAccountScreen({Key? key}) : super(key: key);
  static const String routeName = "CreateAccount";

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends BaseView<CreateAccountScreen,CreateAccountViewModel>
    implements CreateAccountNavigator {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passController = TextEditingController();
  var fNAmeController = TextEditingController();

  var userNameController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
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
                title: Text("Create Account"),
              ),
              body: Form(
                key: frmKey,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.trim() == "") {
                            return "Please Enter Your First Name";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        controller: fNAmeController,
                        decoration: InputDecoration(
                          hintText: "First Name",
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
                        controller: userNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.trim() == "") {
                            return "Please Enter Your User Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "User Name",
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
                        controller: emailController,
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
                          child: Text("Create Account")),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          }, child: Text("Login To My Account"))
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
      viewModel.CreateAccountwithFireBaseAuth(fNAmeController.text,userNameController.text,
          emailController.text, passController.text);
    }
  }


  @override
  CreateAccountViewModel initViewModel() {
    // TODO: implement initViewModel
    return CreateAccountViewModel();
  }

  @override
  void goToHome(MyUser myuser) {
    // TODO: implement goToHome
    var provider = Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName,
        arguments: myuser);
  }
}
