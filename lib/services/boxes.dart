import 'package:google_keep_assignment1/models/Note.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Note> getNote() => Hive.box<Note>('note');

  // Box for storing automatic sync switch value
  static Box syncBox = Hive.box('syncBox');
}
