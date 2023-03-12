import 'package:hive/hive.dart';

// .g stands for generated. This file is generated using
// 'flutter packages pub run buid_runner build' command
part 'Note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? content;

  @HiveField(3)
  DateTime? dateAdded;

  // Default Constructor
  Note({/*this.userId,*/ this.title, this.content, this.dateAdded});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      //userId: map['userId'],
      title: map['title'],
      content: map['content'],
      dateAdded: DateTime.tryParse(map['dateAdded']),
    );
  }

  // Below function returns a map
  Map<String, dynamic> toMap() {
    return {
      // 'userId': userId,
      'title': title,
      'content': content,
      'dateAdded': dateAdded!.toIso8601String(),
    };
  }
}
