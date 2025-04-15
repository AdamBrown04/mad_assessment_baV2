import 'package:flutter/material.dart';

class Newgamescreen extends StatefulWidget {
  const Newgamescreen({super.key});

  @override
  State<Newgamescreen> createState() => _NewgamescreenState();
}

class _NewgamescreenState extends State<Newgamescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Stats"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}