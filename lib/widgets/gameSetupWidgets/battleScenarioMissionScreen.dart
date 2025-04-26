import 'package:flutter/material.dart';

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
            onTap: () {},
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Seek and Destroy"),
            subtitle: Text("Destroy the enemy forces"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Key Positions"),
            subtitle: Text("Capture more objectives than your opponent"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Breakthrough"),
            subtitle: Text("Attempt to move your forces into the enemy's deployment zone or off their table edge"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Top Secret"),
            subtitle: Text("Collect the intelligence and extract it off your deployment zone"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Demolition"),
            subtitle: Text("Destroy the opponet's headquarters whilst protecting your own"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          Divider(height: 1, color: Colors.grey),
          ListTile(
            title: Text("Hold Until Relieved"),
            subtitle: Text("Control the objective whilst preventing the enemy from doing so"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
        ],
      )),
    );
  }
}
