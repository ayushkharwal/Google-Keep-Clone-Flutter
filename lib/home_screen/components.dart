import 'package:flutter/material.dart';
import 'package:google_keep_assignment1/search_screen.dart/search_screen.dart';

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
