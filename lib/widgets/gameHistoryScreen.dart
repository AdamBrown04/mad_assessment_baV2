import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/navigation/bottomnavbar.dart';
import 'package:mad_assessment_ba/services/databaseServices.dart';
import 'package:mad_assessment_ba/widgets/gamePreviewScreen.dart';
import 'package:mad_assessment_ba/widgets/newGameScreen.dart';
import 'package:mad_assessment_ba/widgets/profileScreen.dart';
import 'package:mad_assessment_ba/widgets/statsPageScreen.dart';

class Gamehistoryscreen extends StatefulWidget {
  const Gamehistoryscreen({super.key});

  @override
  State<Gamehistoryscreen> createState() => _GamehistoryscreenState();
}

class _GamehistoryscreenState extends State<Gamehistoryscreen> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> gameHistoryList = [];
  static const List<Widget> _widgetOptions = <Widget>[
    Gamehistoryscreen(),
    Statspagescreen(),
    Profilescreen()
  ];

  Future<void> displayAllGameRecords() async {
    final List<Map<String, dynamic>> getGameHistory =
        await Databaseservices.getAllGameHistory();
    setState(() {
      gameHistoryList = getGameHistory;
    });
  }

  void navigationBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Gamehistoryscreen()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Statspagescreen()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profilescreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return navbar(
      currentIndex: _selectedIndex,
      body: Scaffold(
        appBar: AppBar(
          title: Text("Games"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Newgamescreen()));
              },
            )
          ],
        ),
        body: SafeArea(
            child: Center(
          child: ListView.builder(
            itemCount: gameHistoryList.length,
            itemBuilder: (context, index) {
              return Gamepreviewscreen(
                  gameHistoryID: gameHistoryList[index]['gameID']);
            },
          ),
        )),
      ),
    );
  }
}
