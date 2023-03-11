import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/home_screen/home_screen.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Model Adapter
  Hive.registerAdapter(NoteAdapter());

  // Opening Hive box
  await Hive.openBox<Note>('note');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Keep',
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}
