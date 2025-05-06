import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/widgets/gameSetupWidgets/setupPlayerDetailsForGameScreen.dart';

class Narrativescenarioscreen extends StatefulWidget {
  const Narrativescenarioscreen({super.key});

  @override
  State<Narrativescenarioscreen> createState() =>
      _NarrativescenarioscreenState();
}

class _NarrativescenarioscreenState extends State<Narrativescenarioscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Narrative Scenario",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text("Random"),
              subtitle: Text("Select a random scenario"),
              trailing: Icon(Icons.shuffle),
              onTap: () {
                Navigator.pop(context);
                int randomMission = Random().nextInt(5) + 1;
                String? mission;
                String? deploymentZone;
                switch (randomMission) {
                  case 1:
                    mission = "Envelopment";
                    deploymentZone = "Long Edges";
                    break;
                  case 2:
                    mission = "Manhunt";
                    deploymentZone = "Long Edges";
                    break;
                  case 3:
                    mission = "Point Defence";
                    deploymentZone = "Long Edges";
                    break;
                  case 4:
                    mission = "Land Grab";
                    deploymentZone = "Quarters";
                    break;
                  case 5:
                    mission = "Surrounded!";
                    deploymentZone = "Quarters";
                    break;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Setupplayerdetailsforgamescreen(),
                    settings: RouteSettings(
                      arguments: {
                        'gameType': "Narrative",
                        'mission': mission,
                        'deploymentType': "narrative",
                        'deploymentZone': deploymentZone,
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              title: Text("Envelopment"),
              subtitle: Text(
                  "The attacker must try to move their units into the defender's deployment zone or off their table edge"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Setupplayerdetailsforgamescreen(),
                    settings: RouteSettings(
                      arguments: {
                        'gameType': "Narrative",
                        'mission': "Envelopment",
                        'deploymentType': "narrative",
                        'deploymentZone': "Long Edges",
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              title: Text("Manhunt"),
              subtitle: Text("Capture the defender's highest-ranking offficer"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Setupplayerdetailsforgamescreen(),
                    settings: RouteSettings(
                      arguments: {
                        'gameType': "Narrative",
                        'mission': "Manhunt",
                        'deploymentType': "narrative",
                        'deploymentZone': "Long Edges",
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              title: Text("Point Defence"),
              subtitle: Text(
                  "The attacker must try to capture three objectives, the defender must try to stop them"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Setupplayerdetailsforgamescreen(),
                    settings: RouteSettings(
                      arguments: {
                        'gameType': "Narrative",
                        'mission': "Point Defence",
                        'deploymentType': "narrative",
                        'deploymentZone': "Long Edges",
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              title: Text("Land Grab"),
              subtitle: Text(
                  "Attempt to sieze the most table quarters while also trying to destroy your opponent's units"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Setupplayerdetailsforgamescreen(),
                    settings: RouteSettings(
                      arguments: {
                        'gameType': "Narrative",
                        'mission': "Land Grab",
                        'deploymentType': "narrative",
                        'deploymentZone': "Quarters",
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              title: Text("Surrounded!"),
              subtitle: Text(
                  "Attempt to destroy the enemy whilst preserving your own"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Setupplayerdetailsforgamescreen(),
                    settings: RouteSettings(
                      arguments: {
                        'gameType': "Narrative",
                        'mission': "Surrounded!",
                        'deploymentType': "narrative",
                        'deploymentZone': "Quarters",
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
