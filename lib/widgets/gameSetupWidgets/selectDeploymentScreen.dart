import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/widgets/gameSetupWidgets/setupPlayerDetailsForGameScreen.dart';

class Selectdeploymentscreen extends StatefulWidget {
  const Selectdeploymentscreen({super.key});

  @override
  State<Selectdeploymentscreen> createState() => _SelectdeploymentscreenState();
}

class _SelectdeploymentscreenState extends State<Selectdeploymentscreen> {
  String? gameType;
  String? mission;
  String? deploymentType;
  String? deploymentZone;
  bool isLong = false;
  bool isQuaters = false;
  bool isMeetingEngagement = false;
  bool isPreparedPositions = false;
  bool isFogOfWar = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      setState(() {
        mission = args['mission'];
        gameType = args['gameType'];
      });
    }
  }

  bool? verifyFullInput() {
    if (!isLong && !isQuaters) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please select a deployment zone."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return false;
    }

    if (!isMeetingEngagement && !isPreparedPositions && !isFogOfWar) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please select a deployment type."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Deployment"),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text("Deployment Zone",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Random"),
            subtitle: Text("Select a random deployment zone"),
            trailing: Icon(Icons.shuffle),
            onTap: () {
              isLong = false;
              isQuaters = false;
              int randomDeploymentZone = Random().nextInt(2);
              switch (randomDeploymentZone) {
                case 0:
                  isLong = true;
                  deploymentZone = "Long Edges";
                  break;
                case 1:
                  isQuaters = true;
                  deploymentZone = "Quarters";
                  break;
              }
              setState(() {});
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Long Edges"),
            subtitle: Text("Deployment along the long edges of the table"),
            trailing: Checkbox(
                value: isLong,
                onChanged: (value) {
                  setState(() {
                    deploymentZone = "Long Edges";
                  });
                }),
            onTap: () {
              setState(() {
                isLong = !isLong;
                isQuaters = false;
                deploymentZone = "Long Edges";
              });
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Quarters"),
            subtitle: Text("Deployment in the quarters of the table"),
            trailing: Checkbox(
                value: isQuaters,
                onChanged: (value) {
                  setState(() {
                    deploymentZone = "Quarters";
                  });
                }),
            onTap: () {
              setState(() {
                isQuaters = !isQuaters;
                isLong = false;
                deploymentZone = "Quarters";
              });
            },
          ),
          Divider(height: 1, color: Colors.grey),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text("Deployment type",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Random"),
            subtitle: Text("Select a random deployment type"),
            trailing: Icon(Icons.shuffle),
            onTap: () {
              setState(() {
                isMeetingEngagement = false;
                isPreparedPositions = false;
                isFogOfWar = false;
              });
              int randomMission = Random().nextInt(3);
              switch (randomMission) {
                case 0:
                  isMeetingEngagement = true;
                  deploymentType = "Meeting Engagement";
                  break;
                case 1:
                  isPreparedPositions = true;
                  deploymentType = "Prepared Positions";
                  break;
                case 2:
                  isFogOfWar = true;
                  deploymentType = "Fog of War";
                  break;
              }
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Meeting Engagement"),
            subtitle: Text("Units start off the table and come in Turn 1"),
            trailing: Checkbox(
                value: isMeetingEngagement,
                onChanged: (value) {
                  setState(() {
                    deploymentType = "Meeting Engagement";
                  });
                }),
            onTap: () {
              setState(() {
                deploymentType = "Meeting Engagement";
                isMeetingEngagement = !isMeetingEngagement;
                isPreparedPositions = false;
                isFogOfWar = false;
              });
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Prepared Positions"),
            subtitle: Text("Units not in reserve start on the table"),
            trailing: Checkbox(
                value: isPreparedPositions,
                onChanged: (value) {
                  setState(() {
                    deploymentType = "Prepared Positions";
                  });
                }),
            onTap: () {
              setState(() {
                deploymentType = "Prepared Positions";
                isPreparedPositions = !isPreparedPositions;
                isMeetingEngagement = false;
                isFogOfWar = false;
              });
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Fog of War"),
            subtitle:
                Text("Half or less of the player's units start on the table"),
            trailing: Checkbox(
                value: isFogOfWar,
                onChanged: (value) {
                  setState(() {
                    deploymentType = "Fog of War";
                  });
                }),
            onTap: () {
              setState(() {
                deploymentType = "Fog of War";
                isFogOfWar = !isFogOfWar;
                isMeetingEngagement = false;
                isPreparedPositions = false;
              });
            },
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
                  bool canContinue = true;
                  canContinue = verifyFullInput()!;
                  if (canContinue) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Setupplayerdetailsforgamescreen(),
                            settings: RouteSettings(
                              arguments: {
                                'gameType': gameType,
                                'mission': mission,
                                'deploymentType': deploymentType,
                                'deploymentZone': deploymentZone,
                              },
                            )));
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
