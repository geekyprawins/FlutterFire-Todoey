import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/todoscreen.dart';
import './widgets/waiting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text(snapshot.error.toString())),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Waiting();
        }
        return MaterialApp(
          title: "Todo App",
          home: TodoScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
