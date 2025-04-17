import 'package:flutter/material.dart';

class navbar extends StatefulWidget {
  const navbar({super.key, required this.currentIndex, required this.body});
  final int currentIndex;
  final Widget body;

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  void _onItemTapped(int index){
    if(index == widget.currentIndex) return;

    switch(index){
      case 0:
        Navigator.pushReplacementNamed(context, '/widgets/gameHistoryScreen');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/widgets/statsPageScreen');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/widgets/profileScreen');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Stats"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}