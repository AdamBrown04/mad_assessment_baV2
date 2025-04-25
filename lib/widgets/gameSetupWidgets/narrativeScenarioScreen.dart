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
              title: Text("Envelopment"),
              subtitle: Text(""),
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
                        'deploymentType': "Long Edges",
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              title: Text("Manhunt"),
              subtitle: Text(""),
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
                        'deploymentType': "Long Edges",
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              title: Text("Point Defence"),
              subtitle: Text(""),
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
                        'deploymentType': "Long Edges",
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              title: Text("Land Grab"),
              subtitle: Text(""),
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
                        'deploymentType': "Quarters",
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(height: 1, color: Colors.grey),
            ListTile(
              title: Text("Surrounded!"),
              subtitle: Text(""),
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
                        'deploymentType': "Quarters",
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
