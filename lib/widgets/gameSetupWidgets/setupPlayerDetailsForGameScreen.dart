import 'package:flutter/material.dart';

class Setupplayerdetailsforgamescreen extends StatefulWidget {
  const Setupplayerdetailsforgamescreen({super.key});

  @override
  State<Setupplayerdetailsforgamescreen> createState() => _SetupplayerdetailsforgamescreenState();
}

class _SetupplayerdetailsforgamescreenState extends State<Setupplayerdetailsforgamescreen> {
  bool isIdentical = true;
  int playerPoints = 0;
  int opponentPoints = 0;

  final TextEditingController playerPointsController = TextEditingController();
  final TextEditingController opponentPointsController = TextEditingController();

  @override
  void dispose() {
    playerPointsController.dispose();
    opponentPointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player Details",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Identical point values",
                      style: TextStyle(fontSize: 16)),
                  Switch(
                    value: isIdentical,
                    onChanged: (value) {
                      setState(() {
                        isIdentical = value;
                        if (isIdentical) {
                          opponentPoints = playerPoints;
                          opponentPointsController.text =
                              playerPoints.toString(); 
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your points", style: TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.175,
                      child: TextField(
                        controller: playerPointsController, 
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Points",
                          counterText: "",
                        ),
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        onChanged: (value) => setState(() {
                          playerPoints = int.tryParse(value) ?? 0;
                          if (isIdentical) {
                            opponentPoints = playerPoints;
                            opponentPointsController.text =
                                playerPoints.toString(); 
                          }
                        }),
                      ),
                    ),
                  ),
                  Text("VS ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Opp's points", style: TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.175,
                      child: TextField(
                        controller: opponentPointsController, 
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Points",
                          counterText: "",
                        ),
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        enabled: !isIdentical, 
                        onChanged: (value) => setState(() {
                          opponentPoints = int.tryParse(value) ?? 0;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
