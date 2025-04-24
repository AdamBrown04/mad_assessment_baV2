import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/providers/gameDetailsProvider.dart';
import 'package:provider/provider.dart';

class Setupplayerdetailsforgamescreen extends StatefulWidget {
  const Setupplayerdetailsforgamescreen({super.key});

  @override
  State<Setupplayerdetailsforgamescreen> createState() =>
      _SetupplayerdetailsforgamescreenState();
}

class _SetupplayerdetailsforgamescreenState
    extends State<Setupplayerdetailsforgamescreen> {
  bool isIdentical = true;
  int? playerPoints;
  int? opponentPoints;
  String? playerName;
  String? opponentName;
  String? playerArmy;
  String? opponentArmy;

  List<String> availableArmies = [
    "British Army",
    "German Army",
    "American Army",
    "Japanese Army",
    "Soviet Army",
    "Italian Army",
    "French Army",
    "Partisan Army",
    "Polish Army",
    "Hungarian Army",
    "Romanian Army",
    "Finnish Army",
    "Belguim Army",
    "Dutch Army",
    "Greek Army",
    "Norwegian Army",
    "Bulgarian Army",
  ];
  final TextEditingController playerPointsController = TextEditingController();
  final TextEditingController opponentPointsController =
      TextEditingController();

  @override
  void dispose() {
    playerPointsController.dispose();
    opponentPointsController.dispose();
    super.dispose();
  }

  void validateUserInput() {
    if (playerPoints == 0 ||
        opponentPoints == 0 ||
        playerPoints == null ||
        opponentPoints == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please enter points for both players"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          });
      return;
    }
    if (playerName == null || playerName == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please enter your name"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          });
      return;
    }
    if (opponentName == null || opponentName == "") {
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Error"),
          content: Text("Please enter your opponent's name"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      });
      return;
    }
    if (playerArmy == null || playerArmy == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please select your army"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          });
      return;
    }
    if (opponentArmy == null || opponentArmy == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please select your opponent's army"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          });
      return;
    } else {
          // Update the shared data using the provider
    Provider.of<GameDetailsProvider>(context, listen: false).updateGameDetails(
      playerName: playerName ?? "Player",
      opponentName: opponentName ?? "Opponent",
      playerArmy: playerArmy,
      opponentArmy: opponentArmy,
      playerPoints: playerPoints ?? 0,
      opponentPoints: opponentPoints ?? 0,
    );
      Navigator.pop(context);
    }
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Player Setup",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Text("You",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Player Name",
                    icon: Icon(Icons.person),
                    counterText: "",
                  ),
                  maxLength: 20,
                  onChanged: (value) => setState(() {
                    playerName = value;
                  }),
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: DropdownButton(
                items: availableArmies
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    playerArmy = value;
                  });
                },
                hint: Text("Select Army"),
                value: playerArmy,
                isExpanded: true,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Text("Opponent",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Opponent Name",
                    icon: Icon(Icons.person),
                    counterText: "",
                  ),
                  maxLength: 20,
                  onChanged: (value) => setState(() {
                    opponentName = value;
                  }),
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: DropdownButton(
                items: availableArmies
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    opponentArmy = value;
                  });
                },
                hint: Text("Select Army"),
                value: opponentArmy,
                isExpanded: true,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Points Setup",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
                  Text("You", style: TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
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
                  Text("VS ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Opponent", style: TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
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
                    validateUserInput();
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
