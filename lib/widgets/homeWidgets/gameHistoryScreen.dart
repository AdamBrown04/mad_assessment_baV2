import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/navigation/bottomnavbar.dart';
import 'package:mad_assessment_ba/providers/gameDetailsProvider.dart';
import 'package:mad_assessment_ba/services/databaseServices.dart';
import 'package:mad_assessment_ba/widgets/gamePreviewScreen.dart';
import 'package:mad_assessment_ba/widgets/gameSetupWidgets/newGameScreen.dart';
import 'package:provider/provider.dart';

class Gamehistoryscreen extends StatefulWidget {
  const Gamehistoryscreen({super.key});

  @override
  State<Gamehistoryscreen> createState() => _GamehistoryscreenState();
}

class _GamehistoryscreenState extends State<Gamehistoryscreen> {
  List<Map<String, dynamic>> gameHistoryList = [];

  Future<void> displayAllGameRecords() async {
    final List<Map<String, dynamic>> getGameHistory =
        await Databaseservices.getAllGameHistory();
    setState(() {
      gameHistoryList = getGameHistory;
    });
  }

  @override
  void initState() {
    super.initState();
    displayAllGameRecords();
  }
  

  @override
  Widget build(BuildContext context) {
    return navbar(
      currentIndex: 0,
      body: Scaffold(
        appBar: AppBar(
          title: Text("Games", style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Newgamescreen()));
                Provider.of<GameDetailsProvider>(context, listen: false)
                    .resetGameDetails();
              },
            )
          ],
        ),
        body: SafeArea(
          child: gameHistoryList.isEmpty
              ? const Center(
                  child: Text("No game records found."),
                )
              : ListView.builder(
                  itemCount: gameHistoryList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: Gamepreviewscreen(
                          gameHistoryID: gameHistoryList[index]['gameID'],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
