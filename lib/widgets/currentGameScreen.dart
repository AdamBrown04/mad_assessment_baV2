import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/services/notification_services.dart';
import 'package:mad_assessment_ba/widgets/gameOverviewScreen.dart';

// ignore: must_be_immutable
class Currentgamescreen extends StatefulWidget {
  Currentgamescreen({
    super.key,
    required this.remindMeToTakePictures,
    required this.playedDay,
    required this.opponentPoints,
    required this.playerPoints,
    this.opponentArmy,
    this.playerArmy,
    required this.deploymentType,
    required this.mission,
    required this.gameType,
    required this.deploymentZone,
    required this.gameDescription,
    required this.opponentName,
    required this.playerName,
    required this.gameTurn,
    required this.opponentScore,
    required this.playerScore,
  });

  final String playerName;
  final String opponentName;
  final String? playerArmy;
  final String? opponentArmy;
  final String gameDescription;
  final String gameType;
  final String mission;
  final String deploymentType;
  final int playerPoints;
  final int opponentPoints;
  final DateTime playedDay;
  final bool remindMeToTakePictures;
  int playerScore = 0;
  int opponentScore = 0;
  final int gameTurn;
  final String deploymentZone;

  @override
  State<Currentgamescreen> createState() => _CurrentgamescreenState();
}

class _CurrentgamescreenState extends State<Currentgamescreen> {
  int playerScoreThisTurn = 0;
  int opponentScoreThisTurn = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.playerName} vs ${widget.opponentName} | ${widget.playerScore} vs ${widget.opponentScore}"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            //This is used to close all of the current game screens that are open and return to the home screen
            for (var i = 0; i < widget.gameTurn; i++) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Turn ${widget.gameTurn}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(widget.playerName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("${widget.playerArmy}: ${widget.playerPoints} points",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Points this turn"),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (playerScoreThisTurn > 0) {
                                setState(() {
                                  setState(() {
                                    widget.playerScore -= 1;
                                    playerScoreThisTurn -= 1;
                                  });
                                });
                              }
                            },
                            icon: Icon(Icons.remove)),
                        Text(playerScoreThisTurn.toString()),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                widget.playerScore += 1;
                                playerScoreThisTurn += 1;
                              });
                            },
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text(widget.opponentName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("${widget.opponentArmy}: ${widget.opponentPoints} points",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Points this turn"),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (opponentScoreThisTurn > 0) {
                                setState(() {
                                  widget.opponentScore -= 1;
                                  opponentScoreThisTurn -= 1;
                                });
                              }
                            },
                            icon: Icon(Icons.remove)),
                        Text(opponentScoreThisTurn.toString()),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                widget.opponentScore += 1;
                                opponentScoreThisTurn += 1;
                              });
                            },
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            if (widget.gameTurn < 7)
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (widget.remindMeToTakePictures) {
                          await NotificationServices.displayNotification(
                            title: "Take Photograph",
                            body: "Tap to open your camera app.",
                          );
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Currentgamescreen(
                                      remindMeToTakePictures:
                                          widget.remindMeToTakePictures,
                                      playedDay: widget.playedDay,
                                      opponentPoints: widget.opponentPoints,
                                      playerPoints: widget.playerPoints,
                                      opponentArmy: widget.opponentArmy,
                                      playerArmy: widget.playerArmy,
                                      deploymentType: widget.deploymentType,
                                      mission: widget.mission,
                                      gameType: widget.gameType,
                                      gameDescription: widget.gameDescription,
                                      opponentName: widget.opponentName,
                                      playerName: widget.playerName,
                                      gameTurn: widget.gameTurn + 1,
                                      opponentScore: widget.opponentScore,
                                      playerScore: widget.playerScore,
                                      deploymentZone: widget.deploymentZone,
                                    )));
                      },
                      child: Text("Next Turn", style: TextStyle(fontSize: 20))),
                ),
              ),
            if (widget.gameTurn > 1)
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Previous Turn",
                          style: TextStyle(fontSize: 20))),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      for (var i = 0; i < widget.gameTurn; i++) {
                        Navigator.pop(context);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Gameoverviewscreen(
                                    opponentPoints: widget.opponentPoints,
                                    playerPoints: widget.playerPoints,
                                    opponentArmy: widget.opponentArmy,
                                    playerArmy: widget.playerArmy,
                                    opponentName: widget.opponentName,
                                    playerName: widget.playerName,
                                    gameTurn: widget.gameTurn,
                                    opponentScore: widget.opponentScore,
                                    playerScore: widget.playerScore,
                                    playedDay: widget.playedDay,
                                    deploymentType: widget.deploymentType,
                                    mission: widget.mission,
                                    gameType: widget.gameType,
                                    deploymentZone: widget.deploymentZone,
                                  )));
                    },
                    child: Text("End Game", style: TextStyle(fontSize: 20))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
