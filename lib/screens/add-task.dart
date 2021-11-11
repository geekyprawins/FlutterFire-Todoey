import 'package:flutter/material.dart';
import '../backend/cloud-storage.dart';

class AddTaskScreen extends StatelessWidget {
  CloudStorage cloudStorage = CloudStorage();
  late String newTaskTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 30.0,
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              style: TextStyle(color: Colors.black54),
              decoration: InputDecoration(),
              cursorColor: Colors.black54,
              cursorHeight: 25,
              cursorWidth: 2.0,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            TextButton(
              onPressed: () {
                // add functionality
                // addTaskCallback(newTaskTitle);
                cloudStorage.createNewTask(newTaskTitle);
                print("Added new task: $newTaskTitle");
                Navigator.pop(context);
              },
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orangeAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
