import 'package:flutter/material.dart';

class Task {

}
class ShowDialog {


 static Future<void> showMyDialog(BuildContext context,Function delete,Task task) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are You Confirm to delete this Task ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm',style: TextStyle(color: Colors.red),),
              onPressed: () {
               delete(task);
               Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }
}