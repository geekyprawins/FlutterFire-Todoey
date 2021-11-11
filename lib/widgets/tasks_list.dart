import 'package:flutter/material.dart';
import 'package:todo_flutterfire/models/task.dart';
import 'package:todo_flutterfire/widgets/waiting.dart';
import 'task_tile.dart';
import '../backend/cloud-storage.dart';
import '../widgets/task_tile.dart';

class TasksList extends StatefulWidget {
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  CloudStorage cloudStorage = CloudStorage();
  ScrollController controller = ScrollController();
  int present = 9;

  void loadMore() {
    setState(() {
      present += 9;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          print("List ended!!!");
          loadMore();
        }
        return true;
      },
      child: StreamBuilder<List<Task>?>(
        stream: cloudStorage.listTodos(present),
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
      ),
    );
  }
}
