import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/create_note_screen/create_note_screen.dart';
import 'package:google_keep_assignment1/home_screen/components.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:google_keep_assignment1/provider/notes_provider.dart';
import 'package:google_keep_assignment1/services/boxes.dart';
import 'package:google_keep_assignment1/services/firebase_database_methods.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //bool _isLongPressed = false;
  void _onNoteLongPress(int index, NotesProvider notesProvider) {
    // setState(() {
    //   _isLongPressed = true;
    // });
    notesProvider.deleteNoteAt(index);
  }

  late Box _hiveBox;
  bool syncSwitchVal = true;
  bool internetConnectivity = true;
  // Uri endPointUrl = Uri.parse(
  //     'https://keep-clone-c8ae9-default-rtdb.asia-southeast1.firebasedatabase.app/');
  // List<NotesUsingHttp> notesUsingHttp = [];

  // getting notes data from http
  // gettingNotesDataFromHttp() {
  //   http.get(endPointUrl).then((response) {
  //     if (response.statusCode == 200) {
  //       // Decoding json response
  //       var myData = jsonDecode(response.body);
  //       print(myData);
  //       List<NotesUsingHttp> httpFetchedNotes = [];
  //       for (var note in myData) {
  //         httpFetchedNotes.add(NotesUsingHttp.fromJson(note));
  //       }
  //       setState(() {
  //         notesUsingHttp = httpFetchedNotes;
  //       });
  //     } else {
  //       print('Resquest failed with status: ${response.statusCode}');
  //     }
  //   }).catchError((error) {
  //     print("Error occured: $error");
  //   });
  // }

  // init() function used for subscribing to internet connectivity changes
  @override
  initState() {
    super.initState();
    _hiveBox = Hive.box('switchBox');
    syncSwitchVal = _hiveBox.get('switch') ?? false;

    // Subscribe to internet connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          internetConnectivity = false;
        });
      } else {
        setState(() {
          internetConnectivity = true;
        });

        // Sync data with Firebase when connectivity is available
        syncDataWithFirebase();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],

        // Floating action button
        floatingActionButton: floatingActionButton(),
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

              // Sync Tile
              GestureDetector(
                onTap: () {
                  syncDataWithFirebase();
                },
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    //height: 20,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.cloud_sync_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Sync',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //const Divider(color: Colors.grey, height: 5),

              const SizedBox(height: 10),

              // Automatic sync Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Automatically Sync',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  CupertinoSwitch(
                      activeColor: Colors.green,
                      value: syncSwitchVal,
                      onChanged: (value) {
                        setState(() => this.syncSwitchVal = value);

                        // Storing switch value in the hive box
                        Boxes.syncBox.put('syncEnabeld', value);

                        // If sync is enabled, sync the data to Firebase database
                        if (value) {
                          if (internetConnectivity) {
                            syncDataWithFirebase();
                          }
                        }
                      }),
                ],
              ),

              const Spacer(),

              // Logout tab
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.red,
                    size: 28,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: bottomNavigationBar(),

        // Body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              children: [
                // Search Bar/ Edit Bar
                //_isLongPressed == false ? searchBar() : editBar(_isLongPressed),
                searchBar(),

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
                          itemCount: notesProvider
                              .notes.length, // notesUsingHttp.length,
                          crossAxisCount: 4,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          staggeredTileBuilder: (index) =>
                              const StaggeredTile.fit(2),
                          itemBuilder: (context, index) {
                            Note currentNote = notesProvider.notes[index];

                            return InkWell(
                              onLongPress: () {
                                _onNoteLongPress(index, notesProvider);
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
                                      //notesUsingHttp[index].title,
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
                                      // notesUsingHttp[index].content,
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

// class NotesUsingHttp {
//   final String title;
//   final String content;

//   NotesUsingHttp({
//     required this.title,
//     required this.content,
//   });

//   factory NotesUsingHttp.fromJson(Map<String, dynamic> json) {
//     return NotesUsingHttp(
//       title: json['title'],
//       content: json['content'],
//     );
//   }
// }
