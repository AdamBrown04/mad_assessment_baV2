import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Gameoverviewscreen extends StatefulWidget {
  const Gameoverviewscreen({
    super.key,
    required this.opponentPoints,
    required this.playerPoints,
    this.opponentArmy,
    this.playerArmy,
    required this.opponentName,
    required this.playerName,
    required this.gameTurn,
    required this.opponentScore,
    required this.playerScore,
    required this.playedDay,
    required this.deploymentType,
    required this.mission,
    required this.gameType,
    required this.deploymentZone,
  });

  final dynamic opponentPoints;
  final dynamic playerPoints;
  final dynamic opponentArmy;
  final dynamic playerArmy;
  final dynamic opponentName;
  final dynamic playerName;
  final dynamic gameTurn;
  final dynamic opponentScore;
  final dynamic playerScore;
  final dynamic playedDay;
  final dynamic deploymentType;
  final dynamic mission;
  final dynamic gameType;
  final dynamic deploymentZone;

  @override
  State<Gameoverviewscreen> createState() => _GameoverviewscreenState();
}

class _GameoverviewscreenState extends State<Gameoverviewscreen> {
  final formattedDate = DateFormat("dd/MM/yyyy");
  String getFormattedDate() {
    return formattedDate.format(widget.playedDay);
  }

  String findWinner() {
    if (widget.playerScore > widget.opponentScore) {
      return "Victory";
    } else if (widget.playerScore == widget.opponentScore) {
      return "Draw";
    } else {
      return "Loss";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.playerName} vs ${widget.opponentName} | ${widget.playerScore} vs ${widget.opponentScore}"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Card(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                getFormattedDate(),
                                style: TextStyle(fontSize: 15),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    widget.playerName,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    widget.playerArmy,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "${widget.playerPoints} points",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    "${widget.playerScore} - ${widget.opponentScore}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    findWinner(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    widget.opponentName,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    widget.opponentArmy,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "${widget.opponentPoints} points",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Game Type: ${widget.gameType}",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "Mission: ${widget.mission}",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "Deployment Type: ${widget.deploymentType}",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "Deployment Zone: ${widget.deploymentZone}",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "Game Turn: ${widget.gameTurn}",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        /*
                      In Bolt Action not all missions score the same, this section would show how the points have been scored per objective
                      some missions have multiple scoring actions so this will break down the points scored per objective throughout the game
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.playerName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.opponentName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      */
                      ],
                    ),
                  )),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
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
                    child: Text("Return to Game History",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
