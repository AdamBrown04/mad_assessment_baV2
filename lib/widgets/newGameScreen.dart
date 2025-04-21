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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$playerName vs $opponentName | $playerPoints vs $opponentPoints"), titleTextStyle: TextStyle(fontSize: 18),
      ),
    );
  }
}