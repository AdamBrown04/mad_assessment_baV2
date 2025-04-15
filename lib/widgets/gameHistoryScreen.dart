import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/services/databaseServices.dart';
import 'package:mad_assessment_ba/widgets/gamePreviewScreen.dart';
import 'package:mad_assessment_ba/widgets/newGameScreen.dart';

class Gamehistoryscreen extends StatefulWidget {
  const Gamehistoryscreen({super.key});

  @override
  State<Gamehistoryscreen> createState() => _GamehistoryscreenState();
}

class _GamehistoryscreenState extends State<Gamehistoryscreen> {

  List<Map<String, dynamic>> gameHistoryList = [];

  Future<void> displayAllGameRecords() async{
    final List<Map<String, dynamic>> getGameHistory = await Databaseservices.getAllGameHistory();
    setState(() {
      gameHistoryList = getGameHistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Newgamescreen()));
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Stats"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(child: Center(
        child: ListView.builder(
          itemCount: gameHistoryList.length,
          itemBuilder: (context, index) {
            return Gamepreviewscreen(gameHistoryID: gameHistoryList[index]['gameID']);
        },
      ),)
      ),
    );
  }
}