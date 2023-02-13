import 'package:chatapp/base.dart';
import 'package:chatapp/models/categories.dart';
import 'package:chatapp/screens/addroom/addroom_navigator.dart';
import 'package:chatapp/screens/addroom/addroom_viewmodel.dart';
import 'package:flutter/material.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = "AddRoom";

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var decsController = TextEditingController();
var categories = RoomCategory.getCategories();
late RoomCategory selectedcateg ;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
              title: Text("Add Room"),
            ),
            body: Container(
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Card(
                elevation: 22,
                child: Form(
                  key: frmKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Create New Room",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset("assets/images/addroompic.png"),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: titleController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.trim() == "") {
                              return "Please Enter Room title";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Room Title",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButton<RoomCategory>(
                          value: selectedcateg,
                            items: categories.map((cat) => DropdownMenuItem<RoomCategory>(
                              value: cat,
                                child: Row(children: [
                                  Image.asset(cat.imagepath),
                                  SizedBox(width: 30,),
                                  Text("${cat.name}"),
                                ],))).toList(),
                            onChanged: (categ) {
                              if(categ == null) return;
                              selectedcateg=categ;
                              setState(() {

                              });
                            },),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: decsController,
                          validator: (value) {
                            if (value!.trim() == "") {
                              return " Enter Room Description";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "Room Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              ValidateForm();
                            },
                            child: Text("Create Room")),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  void ValidateForm() {
    if (frmKey.currentState!.validate()) {
      viewModel.addRoomToDB(titleController.text, decsController.text, selectedcateg.id);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedcateg = categories[0];
    viewModel.navigator = this;
  }

  @override
  AddRoomViewModel initViewModel() {
    // TODO: implement initViewModel
    return AddRoomViewModel();
  }

  @override
  void RoomCreated() {
    // TODO: implement RoomCreated
    Navigator.pop(context);
  }
}
