import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:google_keep_assignment1/services/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  // Referencing our hive database/box
//  final box = Hive.box('box');

  // Text Editing Controllers
  TextEditingController titleTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();

  // Writing data in hive database
  Future writeData(var title, var content /*var userId*/) async {
    final note = Note()
      ..title = title
      ..content = content
      //..userId = userId
      ..dateAdded = DateTime.now();

    final box = Boxes.getNote();
    box.add(note);

    print('Note is stored locally.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            noteTextController.text.isEmpty
                ? writeData(
                    titleTextController.text,
                    noteTextController.text,
                  )
                : () {};

            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            // Title Textfield
            TextField(
              controller: titleTextController,
              style: const TextStyle(fontSize: 28),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black45,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Notes TextField
            Expanded(
              child: TextField(
                controller: noteTextController,
                autofocus: true,
                style: const TextStyle(fontSize: 24),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note',
                  hintStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
