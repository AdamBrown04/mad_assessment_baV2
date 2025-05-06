import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/models/gameHistory.dart';
import 'package:mad_assessment_ba/services/databaseServices.dart';
import 'package:mad_assessment_ba/widgets/gameOverviewScreen.dart';

class Gamepreviewscreen extends StatefulWidget {
  const Gamepreviewscreen({super.key, required this.gameHistoryID});

  final int gameHistoryID;

  @override
  State<Gamepreviewscreen> createState() => _GamepreviewscreenState();
}

class _GamepreviewscreenState extends State<Gamepreviewscreen> {
  late Gamehistory gameData = Gamehistory(
    playerName: "Unknown",
    opponentName: "Unknown",
    playerScore: 0,
    opponentScore: 0,
    playedDay: DateTime.now(),
    isPlayerWinner: false,
    deploymentType: "Unknown",
    deploymentZone: "Unknown",
    gameDescription: "Unknown",
    gameType: "Unknown",
    mission: "Unknown",
    playerArmy: "Unknown",
    opponentArmy: "Unknown",
    playerPoints: 0,
    opponentPoints: 0,
    gameID: 0,
  ); // Provide a default value
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGameData();
  }

  Future<void> _fetchGameData() async {
    try {
      final gameDataMap =
          await Databaseservices.getGameHistory(widget.gameHistoryID);
      if (gameDataMap != null) {
        setState(() {
          gameData = Gamehistory.fromMap(gameDataMap);
          isLoading = false; 
        });
      } else {
        throw Exception("Game data not found");
      }
    } catch (e) {
      debugPrint("Error fetching game data: $e");
      setState(() {
        isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListTile(
      title: Text("${gameData.playerName} vs ${gameData.opponentName}"),
      subtitle: Text(
          "Score: ${gameData.playerScore} - ${gameData.opponentScore}\nDate: ${gameData.getFormattedDate}"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Gameoverviewscreen(
              opponentPoints: gameData.opponentPoints,
              playerPoints: gameData.playerPoints,
              opponentName: gameData.opponentName,
              playerName: gameData.playerName,
              gameTurn:
                  gameData.isPlayerWinner ? "Player's Turn" : "Opponent's Turn",
              opponentScore: gameData.opponentScore,
              playerScore: gameData.playerScore,
              playedDay: gameData.playedDay,
              deploymentType: gameData.deploymentType,
              mission: gameData.mission,
              gameType: gameData.gameType,
              deploymentZone: gameData.deploymentZone,
              opponentArmy: gameData.opponentArmy,
              playerArmy: gameData.playerArmy,
            ),
          ),
        );
      },
    );
  }
}
