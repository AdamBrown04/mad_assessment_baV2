import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/widgets/gameSetupWidgets/setupPlayerDetailsForGameScreen.dart';

class Selectgametypescreen extends StatefulWidget {
  const Selectgametypescreen({super.key});

  @override
  State<Selectgametypescreen> createState() => _SelectgametypescreenState();
}

class _SelectgametypescreenState extends State<Selectgametypescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Game Type",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text("Random Mission"),
                subtitle: Text(
                    "Randomised missions that are found within the Bolt Action 3rd edition rulebook"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
              Divider(height: 1, color: Colors.grey),
              ListTile(
                title: Text("Narrative Missions"),
                subtitle: Text(
                    "Narrative missions that are found within the Bolt Action 3rd edition rulebook"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
              Divider(height: 1, color: Colors.grey),
              ListTile(
                title: Text("Compendium Missions"),
                subtitle: Text(
                    "Missions that are found within the Bolt Action 3rd edtion compendium book"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
              Divider(height: 1, color: Colors.grey),
              ListTile(
                title: Text("Custom Missions"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Setupplayerdetailsforgamescreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
