import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/create_note_screen/create_note_screen.dart';
import 'package:google_keep_assignment1/search_screen.dart/search_screen.dart';
import 'package:google_keep_assignment1/services/firebase_database_methods.dart';

// SearchBar
Widget searchBar() {
  return Builder(builder: (context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 4),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const SizedBox(width: 13),
          // Drawer Icon
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            );
          }),
          const SizedBox(width: 10),

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
              width: 220,
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
            backgroundImage: const AssetImage('assets/icons/ic_user.png'),
          )
        ],
      ),
    );
  });
}

// EditBar
Widget editBar(bool isLongPressed) {
  return Builder(builder: (context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 4),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const SizedBox(width: 13),
          // Cancel Icon
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                isLongPressed = false;
              },
              child: const Icon(
                Icons.cancel_rounded,
                color: Colors.black,
              ),
            );
          }),
          const SizedBox(width: 10),

          // Selected Notes Count
          Container(
            height: 50,
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '1',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          // More options
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  });
}

// Drawer
Widget drawer() {
  return Drawer(
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
            settingDataToDatabase();
          },
          child: const ListTile(
            leading: Icon(
              Icons.cloud_sync_rounded,
              color: Colors.black,
              size: 28,
            ),
            title: Text(
              'Sync',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        //const Divider(color: Colors.grey, height: 5),

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
  );
}

// Floating Action Button
Widget floatingActionButton() {
  return Builder(
    builder: (context) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateNoteScreen(isUpdate: false),
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
      );
    },
  );
}

// Bottom Navigation Bar
Widget bottomNavigationBar() {
  return BottomAppBar(
    elevation: 9,
    shape: const CircularNotchedRectangle(),
    notchMargin: 0,
    child: Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
    ),
  );
}
