import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/providers/gameDetailsProvider.dart';
import 'package:mad_assessment_ba/services/notification_services.dart';
import 'package:mad_assessment_ba/widgets/currentGameScreen.dart';
import 'package:mad_assessment_ba/widgets/gameSetupWidgets/selectGameTypeScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Newgamescreen extends StatefulWidget {
  const Newgamescreen({super.key});
  @override
  State<Newgamescreen> createState() => _NewgamescreenState();
}

class _NewgamescreenState extends State<Newgamescreen> {
  String playerName = "Player";
  String opponentName = "Opponent";
  String gameDescription = "Game Description";
  String gameType = "Game Type";
  String mission = "Mission";
  String deploymentType = "Deployment Type";
  String deploymentZone = "Deployment Zone";
  String? playerArmy;
  String? opponentArmy;
  int playerPoints = 0;
  int opponentPoints = 0;
  int playerScore = 0;
  int opponentScore = 0;
  DateTime playedDay = DateTime.now();
  bool remindMeToTakePictures = false;

  void _displayDatePicker() async {
    final playedDay = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 10));
    setState(() {
      if (playedDay != null) {
        this.playedDay = playedDay;
      }
    });
  }

  @override
  void dispose() {
    playerName = "Player";
    opponentName = "Opponent";
    gameDescription = "Game Description";
    gameType = "Game Type";
    mission = "Mission";
    deploymentType = "Deployment Type";
    deploymentZone = "Deployment Zone";
    playerArmy = null;
    opponentArmy = null;
    playerPoints = 0;
    opponentPoints = 0;
    playerScore = 0;
    opponentScore = 0;
    playedDay = DateTime.now();
    remindMeToTakePictures = false;
    GameDetailsProvider().resetGameDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GameDetais = Provider.of<GameDetailsProvider>(context);
    playerName = GameDetais.playerName;
    opponentName = GameDetais.opponentName;
    playerArmy = GameDetais.playerArmy;
    opponentArmy = GameDetais.opponentArmy;
    playerPoints = GameDetais.playerPoints ?? 0;
    opponentPoints = GameDetais.opponentPoints ?? 0;
    gameType = GameDetais.gameType ?? "Game Type";
    mission = GameDetais.mission ?? "Scenario";
    deploymentType = GameDetais.deploymentType ?? "Deployment Type";
    deploymentZone = GameDetais.deploymentZone ?? "Deployment Zone";

    Future<void> getNotificationPermission(bool isSwitchingOn) async {
      if (isSwitchingOn) {
        final status = await Permission.notification.request();
        if (status.isDenied) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Permission Denied"),
                content: Text("Please enable notifications in settings."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "$playerName vs $opponentName | $playerScore vs $opponentScore"),
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Game Setup",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text("Game Date",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.075,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: _displayDatePicker,
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month, size: 25),
                            Text(
                              " ${playedDay.day}/${playedDay.month}/${playedDay.year}",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Game Description",
                  ),
                  onChanged: (value) {
                    setState(() {
                      gameDescription = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Select Game Type",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Selectgametypescreen(),
                            ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("$gameType | $mission",
                              style: TextStyle(fontSize: 18)),
                          Text("$deploymentZone | $deploymentType",
                              style: TextStyle(fontSize: 18)),
                          Text(
                            "Points: $playerPoints vs $opponentPoints",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("Game Options",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        getNotificationPermission(!remindMeToTakePictures);
                        setState(() {
                          remindMeToTakePictures = !remindMeToTakePictures;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt, size: 30),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Remind me to take pictures",
                                    style: TextStyle(fontSize: 16)),
                                Text(
                                    "Shows a notification to take \npictures at the end of each turn",
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          Spacer(),
                          Switch(
                            value: remindMeToTakePictures,
                            onChanged: (value) {
                              setState(() {
                                remindMeToTakePictures = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    //The reason the if statement is only for playerName is because to have filled out the playerName field
                    //means that the user has filled out all other information for the game due to other verification of inputs
                    if (playerName != "Player") {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Currentgamescreen(
                              playerName: playerName,
                              opponentName: opponentName,
                              gameDescription: gameDescription,
                              gameType: gameType,
                              mission: mission,
                              deploymentType: deploymentType,
                              playerArmy: playerArmy,
                              opponentArmy: opponentArmy,
                              playerPoints: playerPoints,
                              opponentPoints: opponentPoints,
                              playedDay: playedDay,
                              remindMeToTakePictures: remindMeToTakePictures,
                              gameTurn: 1,
                              playerScore: playerScore,
                              opponentScore: opponentScore,
                              deploymentZone: deploymentZone,
                            ),
                          ));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content:
                                Text("Please enter information for the game"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
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
                    Provider.of<GameDetailsProvider>(context, listen: false)
                        .resetGameDetails();
                  },
                  child: Text(
                    "Delete Game",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
