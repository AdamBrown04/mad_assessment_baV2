import 'package:flutter/material.dart';

class Currentgamescreen extends StatefulWidget {
  const Currentgamescreen(
      {super.key,
      required bool remindMeToTakePictures,
      required DateTime playedDay,
      required int opponentPoints,
      required int playerPoints,
      String? opponentArmy,
      String? playerArmy,
      required String deploymentType,
      required String mission,
      required String gameType,
      required String gameDescription,
      required String opponentName,
      required String playerName});

    final String? playerName;
    final String? opponentName;
    final String? playerArmy;
    final String? opponentArmy;
    final String? gameDescription;
    final String? gameType;
    final String? mission;
    final String? deploymentType;
    final int? playerPoints;
    final int? opponentPoints;
    final DateTime? playedDay;
    final bool? remindMeToTakePictures;
    final int? playerScore;
    final int? opponentScore;

  @override
  State<Currentgamescreen> createState() => _CurrentgamescreenState();
}

class _CurrentgamescreenState extends State<Currentgamescreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.playerName} vs ${widget.opponentName} | ${widget.playerScore} vs ${widget.opponentScore}"),
      ),
    );
  }
}
