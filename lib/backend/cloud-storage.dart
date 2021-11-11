import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class CloudStorage {
  var todosCollection = FirebaseFirestore.instance.collection("tasks");

  Future createNewTask(String title) async {
    return await todosCollection.add({"title": title, "isDone": false});
  }

  Future addDummyTasks() async {
    for (int i = 1; i < 100; i++) {
      await todosCollection.add({"title": "Task $i", "isDone": false});
    }
  }

  Future finishTask(id) async {
    await todosCollection.doc(id).update({"isDone": true});
  }

  Future removeTask(id) async {
    await todosCollection.doc(id).delete();
  }

  List<Task>? todoFromFirestore(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((e) {
      return Task(
        isDone: e.data()["isDone"],
        name: e.data()["title"],
        id: e.id,
      );
    }).toList();
  }

  Stream<List<Task>?> listTodos(int x) {
    return todosCollection
        .limit(x)
        .orderBy("title")
        .snapshots()
        .map(todoFromFirestore);
  }
}
