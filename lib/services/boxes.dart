import 'package:google_keep_assignment1/models/Note.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Note> getNote() => Hive.box<Note>('note');
}
