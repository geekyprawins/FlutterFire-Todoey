import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';

class CloudStorage {
  var todosCollection = FirebaseFirestore.instance.collection("tasks");

  Future createNewTask(String title) async {
    return await todosCollection.add({"title": title, "isDone": false});
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
        // isDone: false,
        isDone: e.data()["isDone"],
        name: e.data()["title"],
        // name: "Go to Gym",
        id: e.id,
      );
    }).toList();
  }

  Stream<List<Task>?> listTodos() {
    return todosCollection.snapshots().map(todoFromFirestore);
  }
}
