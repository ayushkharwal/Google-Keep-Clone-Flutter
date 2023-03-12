import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/create_note_screen/create_note_screen.dart';
import 'package:google_keep_assignment1/home_screen/components.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:google_keep_assignment1/provider/notes_provider.dart';
import 'package:google_keep_assignment1/services/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Edit Note Function
  editNote(Note note, String title, String content, DateTime dateAdded) {
    note.title = title;
    note.content = content;
    note.dateAdded = dateAdded;

    note.save();
    //Provider.of<NotesProvider>(context, listen: false).updateNote(note);
  }

  @override
  Widget build(BuildContext context) {
    bool isLongPressed = false;
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],

        // Floating action button
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateNoteScreen(
                    isUpdate: true,
                  ),
                ),
              );
            },
            backgroundColor: Colors.grey[100],
            child: const Icon(
              Icons.add_rounded,
              color: Colors.black,
              size: 34,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

        // Drawer
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              // Logo
              SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/icons/logo.png',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10),

              // notes
              const ListTile(
                leading: Icon(
                  Icons.bubble_chart_outlined,
                  color: Colors.black,
                  size: 28,
                ),
                title: Text(
                  'Notes',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Divider(color: Colors.grey, height: 5),

              // Deleted Notes tab
              const ListTile(
                leading: Icon(
                  Icons.delete_rounded,
                  color: Colors.black45,
                  size: 28,
                ),
                title: Text(
                  'Deleted',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: BottomAppBar(
          elevation: 9,
          shape: const CircularNotchedRectangle(),
          notchMargin: 0,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.grey.shade200,
            )),
          ),
        ),

        // Body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              children: [
                // Search Bar
                isLongPressed == false ? searchBar() : editBar(isLongPressed),

                // Notes
                SizedBox(
                  child: ValueListenableBuilder<Box<Note>>(
                    valueListenable: Boxes.getNote().listenable(),
                    builder: (context, box, _) {
                      return StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: notesProvider.notes.length,
                        crossAxisCount: 4,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(2),
                        itemBuilder: (context, index) {
                          Note note = notesProvider.notes[index];
                          return InkWell(
                            onLongPress: () {
                              isLongPressed = true;
                              notesProvider.deleteNoteAt(index);
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateNoteScreen(isUpdate: false),
                                  ));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    note.content!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 15,
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
