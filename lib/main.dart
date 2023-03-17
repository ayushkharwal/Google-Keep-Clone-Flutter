import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/auth_screens/login_screen.dart';
import 'package:google_keep_assignment1/home_screen/home_screen.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:google_keep_assignment1/provider/home_screen_provider.dart';
import 'package:google_keep_assignment1/provider/notes_provider.dart';
import 'package:google_keep_assignment1/services/firebase_auth_methods.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Model Adapter
  Hive.registerAdapter(NoteAdapter());

  // Opening Hive box
  await Hive.openBox<Note>('note');
  await Hive.openBox('switchBox');

  // initializing Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // For Screen change after Authentication
        Provider<FirebaseAuthMethods>(
          create: (context) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),

        // For notes
        ChangeNotifierProvider(
          create: ((context) => NotesProvider()),
        ),

        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Google Keep',
        home: AuthWrapper(),
        routes: {},
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomeScreen();
    }

    return const LoginScreen();
  }
}
