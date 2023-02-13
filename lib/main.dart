import 'package:chatapp/providers/myprovider.dart';
import 'package:chatapp/screens/addroom/addroom_screen.dart';
import 'package:chatapp/screens/chat/chat_view.dart';
import 'package:chatapp/screens/createaccount/create_account.dart';
import 'package:chatapp/screens/home/home_view.dart';
import 'package:chatapp/screens/loginscreen/loginview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( ChangeNotifierProvider(
      create: (BuildContext context)=> MyProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(

      initialRoute: provider.firebaseUser !=null ?HomeScreen.routeName : LoginScreen.routeName ,
      routes: {
        CreateAccountScreen.routeName: (context) => CreateAccountScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
        HomeScreen.routeName : (context) => HomeScreen(),
        AddRoomScreen.routeName : (context) => AddRoomScreen(),
        ChatScreen.routeName : (context) => ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

