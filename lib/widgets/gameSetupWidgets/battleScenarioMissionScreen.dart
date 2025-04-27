import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/widgets/gameSetupWidgets/selectDeploymentScreen.dart';

class Battlescenariomissionscreen extends StatefulWidget {
  const Battlescenariomissionscreen({super.key});

  @override
  State<Battlescenariomissionscreen> createState() =>
      _BattlescenariomissionscreenState();
}

class _BattlescenariomissionscreenState
    extends State<Battlescenariomissionscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Battle Scenario Missions")),
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            title: Text("Random Mission"),
            subtitle: Text("Select a random mission"),
            trailing: Icon(Icons.shuffle),
            onTap: () {
              Navigator.pop(context);
              int randomMission = Random().nextInt(7);
              String? mission;
              switch (randomMission) {
                case 0:
                  mission = "Hold the Line";
                  break;
                case 1:
                  mission = "Seek and Destroy";
                  break;
                case 2:
                  mission = "Key Positions";
                  break;
                case 3:
                  mission = "Breakthrough";
                  break;
                case 4:
                  mission = "Top Secret";
                  break;
                case 5:
                  mission = "Demolition";
                  break;
                case 6:
                  mission = "Hold Until Relieved";
                  break;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Selectdeploymentscreen(),
                      settings: RouteSettings(arguments: {
                        "gameType": "Battle Scenario",
                        "mission": mission,
                      })));
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Seek and Destroy"),
            subtitle: Text("Destroy the enemy forces"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Selectdeploymentscreen(),
                      settings: RouteSettings(arguments: {
                        "gameType": "Battle Scenario",
                        "mission": "Seek and Destroy",
                      })));
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Key Positions"),
            subtitle: Text("Capture more objectives than your opponent"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Selectdeploymentscreen(),
                      settings: RouteSettings(arguments: {
                        "gameType": "Battle Scenario",
                        "mission": "Key Positions",
                      })));
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Breakthrough"),
            subtitle: Text(
                "Attempt to move your forces into the enemy's deployment zone or off their table edge"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Selectdeploymentscreen(),
                      settings: RouteSettings(arguments: {
                        "gameType": "Battle Scenario",
                        "mission": "Breakthrough",
                      })));
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Top Secret"),
            subtitle: Text(
                "Collect the intelligence and extract it off your deployment zone"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Selectdeploymentscreen(),
                      settings: RouteSettings(arguments: {
                        "gameType": "Battle Scenario",
                        "mission": "Top Secret",
                      })));
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Demolition"),
            subtitle: Text(
                "Destroy the opponet's headquarters whilst protecting your own"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Selectdeploymentscreen(),
                      settings: RouteSettings(arguments: {
                        "gameType": "Battle Scenario",
                        "mission": "Demolition",
                      })));
            },
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Hold Until Relieved"),
            subtitle: Text(
                "Control the objective whilst preventing the enemy from doing so"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Selectdeploymentscreen(),
                      settings: RouteSettings(arguments: {
                        "gameType": "Battle Scenario",
                        "mission": "Hold Until Relieved",
                      })));
            },
          ),
        ],
      )),
    );
  }
}
