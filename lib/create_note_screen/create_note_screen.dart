import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:google_keep_assignment1/provider/notes_provider.dart';
import 'package:google_keep_assignment1/services/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class CreateNoteScreen extends StatefulWidget {
  final bool isUpdate;
  final Note? note;

  const CreateNoteScreen({
    super.key,
    required this.isUpdate,
    this.note,
  });

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  NotesProvider notesProvider = NotesProvider();

  // Text Editing Controllers
  TextEditingController titleTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();

  // Writing data in hive database
  writeData(var title, var content /*,var userId,*/) {
    final note = Note()
      ..title = title
      ..content = content
      //..userId = userId
      ..dateAdded = DateTime.now();

    Provider.of<NotesProvider>(context, listen: false).addNote(note);

    print('Note is stored locally.');
  }

  // updateNote() function
  void updateNote() {
    widget.note!.title = titleTextController.text;
    widget.note!.content = noteTextController.text;
    notesProvider.updateNote(widget.note!);
    Navigator.pop(context);
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
                ? titleTextController.text.isEmpty
                : writeData(
                    titleTextController.text,
                    noteTextController.text,
                  );

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
                maxLines: null,
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
