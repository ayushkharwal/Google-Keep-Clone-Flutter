import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/create_note_screen/create_note_screen.dart';
import 'package:google_keep_assignment1/models/Note.dart';
import 'package:google_keep_assignment1/search_screen.dart/search_Screen.dart';
import 'package:google_keep_assignment1/services/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String note1 =
      'NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 v NOTE 1 NOTE 1NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 v NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 v NOTE 1 NOTE 1NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 v NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 v NOTE 1 NOTE 1NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 v NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 v NOTE 1 NOTE 1NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 v NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1';
  String note2 =
      'NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 v NOTE 1 NOTE 1NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 NOTE 1 ';
  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => const CreateNoteScreen(),
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
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                // Search Bar
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      // Drawer Icon
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                      ),

                      // Search Text
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Search your notes',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // List/Grid Icon
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.grid_view_outlined,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 6),

                      // User Profile Pic
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 16,
                        backgroundImage:
                            const AssetImage('assets/icons/ic_user.png'),
                      )
                    ],
                  ),
                ),

                // Notes
                SizedBox(
                  // height: MediaQuery.of(context).size.height - 150,
                  // width: MediaQuery.of(context).size.width,
                  child: ValueListenableBuilder<Box<Note>>(
                    valueListenable: Boxes.getNote().listenable(),
                    builder: (context, box, child) {
                      final note = box.values.toList().cast<Note>();

                      return StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 50,
                        crossAxisCount: 4,
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(2),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(15),
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
                                  '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  index.isEven
                                      ? note1.length > 250
                                          ? "${note1.substring(0, 250)}..."
                                          : note1
                                      : note2,
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
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
