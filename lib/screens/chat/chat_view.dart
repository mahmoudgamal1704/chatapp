import 'package:chatapp/base.dart';
import 'package:chatapp/layout/messagewidget.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/room.dart';
import 'package:chatapp/providers/myprovider.dart';
import 'package:chatapp/screens/chat/chat_navigator.dart';
import 'package:chatapp/screens/chat/chat_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  // const ChatScreen({Key? key}) : super(key: key);
  static const String routeName = 'Chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    var myprov = Provider.of<MyProvider>(context);
    viewModel.room = room;
    viewModel.myuser = myprov.myuser!;
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Stack(children: [
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
              title: Text(room.title),
            ),
            body: Padding(
              padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: StreamBuilder<QuerySnapshot<Message>>(
                          stream: viewModel.readMessages(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }else if (snapshot.hasError){
                              return Text('Some thing went wrong');
                            }else {
                              var messages = snapshot.data!.docs.map((e) => e.data()).toList();
                              viewModel.messages=messages;
                              return  ListView.builder(
                                  itemCount: messages.length,
                                  itemBuilder: (context, index) {
                                    return MessageWidget(messages[index]);
                                  },);
                            }

                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: 'Enter message',
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              viewModel.sendMessage(messageController.text);
                            },
                            child: Row(
                              children: [
                                Text('Send'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.send)
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  ChatViewModel initViewModel() {
    // TODO: implement initViewModel
    return ChatViewModel();
  }

  @override
  void messageAdded() {
    // TODO: implement messageAdded
    messageController.clear();
  }
}
