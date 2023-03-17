import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:google_keep_assignment1/services/boxes.dart';
import 'package:google_keep_assignment1/services/firebase_auth_methods.dart';

DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child('notes');
final auth = FirebaseAuth.instance;

final notes = Boxes.getNote().values.toList().cast<Note>();
final noteList = notes
    .map((note) => {
          'title': note.title,
          'content': note.content,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'dateAdded': note.dateAdded.toString(),
        })
    .toList();

Future syncDataWithFirebase() async {
  await databaseRef.set(noteList);
}
