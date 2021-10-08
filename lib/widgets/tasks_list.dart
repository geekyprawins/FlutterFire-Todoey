import 'package:flutter/material.dart';
import 'package:todo_flutterfire/models/task.dart';
import 'package:todo_flutterfire/widgets/waiting.dart';
import 'task_tile.dart';
import '../backend/cloud-storage.dart';
import '../widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CloudStorage cloudStorage = CloudStorage();
    return StreamBuilder<List<Task>?>(
      stream: cloudStorage.listTodos(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Waiting();
        }
        List<Task>? todos = snapshot.data;
        return ListView.builder(
          itemBuilder: (context, index) {
            final todo = todos![index];
            return TaskTile(
              isChecked: todo.isDone,
              taskTitle: todo.name,
              checkboxCallback: (checkboxState) {
                todos[index].isDone = true;
                cloudStorage.finishTask(todos[index].id);
              },
              longPressCallback: () {
                cloudStorage.removeTask(todos[index].id);
              },
            );
          },
          itemCount: todos!.length,
        );
      },
    );
  }
}
