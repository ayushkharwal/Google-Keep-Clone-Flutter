import 'package:flutter/cupertino.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:google_keep_assignment1/services/boxes.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> _notes = [];

  NotesProvider() {
    loadNotes();
  }

  List<Note> get notes => _notes;

  void loadNotes() {
    final box = Boxes.getNote();
    _notes = box.values.toList().cast<Note>();
    notifyListeners();
  }

  void addNote(Note note) {
    final box = Boxes.getNote();
    box.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    int indexOfNote = notes
        .indexOf(notes.firstWhere((element) => element.title == note.title));
    notes[indexOfNote] = note;
    note.save();
    loadNotes();
  }

  void deleteNoteAt(int index) {
    final box = Boxes.getNote();
    box.deleteAt(index);
    loadNotes();
  }

  void clearNotes() {
    final box = Boxes.getNote();
    box.clear();
    loadNotes();
  }
}
