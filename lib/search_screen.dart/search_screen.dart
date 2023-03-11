import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 7),
              child: TextField(
                decoration: InputDecoration(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  border: InputBorder.none,
                  hintText: 'Search your notes',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
