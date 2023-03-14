import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/create_note_screen/create_note_screen.dart';
import 'package:google_keep_assignment1/home_screen/components.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:google_keep_assignment1/provider/notes_provider.dart';
import 'package:google_keep_assignment1/services/boxes.dart';
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
  @override
  Widget build(BuildContext context) {
    bool isLongPressed = false;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],

        // Floating action button
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

        // Drawer
        drawer: drawer(),

        // Bottom Navigation Bar
        bottomNavigationBar: bottomNavigationBar(),

        // Body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              children: [
                // Search Bar/ Edit Bar
                isLongPressed == false ? searchBar() : editBar(isLongPressed),

                // Notes
                SizedBox(
                  child: Consumer<NotesProvider>(
                      builder: (context, notesProvider, _) {
                    return ValueListenableBuilder<Box<Note>>(
                      valueListenable: Boxes.getNote().listenable(),
                      builder: (context, box, _) {
                        NotesProvider notesProvider =
                            Provider.of<NotesProvider>(context);

                        var myBox = box.values.toList().cast<Note>();

                        // Updates the notes list in the provider
                        notesProvider.setNotes(myBox);

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
                            Note currentNote = notesProvider.notes[index];
                            return InkWell(
                              onLongPress: () {
                                isLongPressed = true;
                                Future.delayed(Duration.zero, () {
                                  notesProvider.deleteNoteAt(index);
                                });
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateNoteScreen(
                                          isUpdate: true, note: currentNote),
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
                                      currentNote.title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      currentNote.content!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 15,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
