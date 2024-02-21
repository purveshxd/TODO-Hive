import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive/models/todo_model.dart';
import 'package:todo_hive/screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init hive
  await Hive.initFlutter();
  // register the hive adapter
  Hive.registerAdapter(TodoAdapter());
  // opens the box
  await Hive.openBox('todo_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.orangeAccent,
      ),
      home: const Homepage(),
    );
  }
}
