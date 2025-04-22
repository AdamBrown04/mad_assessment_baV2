import 'package:flutter/material.dart';

class Newgamescreen extends StatefulWidget {
  const Newgamescreen({super.key});

  @override
  State<Newgamescreen> createState() => _NewgamescreenState();
}

class _NewgamescreenState extends State<Newgamescreen> {
  String playerName = "Player";
  String opponentName = "Opponent";
  int playerPoints = 0;
  int opponentPoints = 0;
  DateTime playedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "$playerName vs $opponentName | $playerPoints vs $opponentPoints"),
        titleTextStyle: TextStyle(fontSize: 18),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.05, // 80% of screen width
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.calendar_month),
                    Text(" ${playedDay.day}/${playedDay.month}/${playedDay.year}"),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.075, // 80% of screen width
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Game Description",
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
