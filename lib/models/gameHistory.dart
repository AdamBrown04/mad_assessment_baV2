import 'package:intl/intl.dart';

class Gamehistory {
  final int gameID;
  final String playerName;
  final String opponentName;
  final String playerArmy;
  final String opponentArmy;
  final String gameDescription;
  final String gameType;
  final String mission;
  final String deploymentType;
  final int playerPoints;
  final int opponentPoints;
  int playerScore;
  int opponentScore;
  final DateTime playedDay;
  bool isPlayerWinner;

  final formattedDate = DateFormat("dd/MM/yyyy");

  Gamehistory({
    required this.gameID,
    required this.playerName,
    required this.opponentName,
    required this.playerPoints,
    required this.opponentPoints,
    required this.playerArmy,
    required this.opponentArmy,
    required this.playedDay,
    required this.isPlayerWinner,
    required this.deploymentType,
    required this.gameDescription,
    required this.gameType,
    required this.mission,
    required this.playerScore,
    required this.opponentScore,
  });

  String get getFormattedDate {
    return formattedDate.format(playedDay);
  }

  String outputWinner() {
    if (isPlayerWinner) {
      return "Victory";
    }
    else if (playerScore == opponentScore) {
      return "Draw";
    }
    else {
      return "Loss";
    }
  }

  void findIfPlayerWon() {
    if (playerScore > opponentScore) {
      isPlayerWinner = true;
    } else if (playerScore < opponentScore) {
      isPlayerWinner = false;
    } else {
      isPlayerWinner = false; // Draw
    }
  }

  void incrementScore(bool isPlayer, int scoreIncrease){
    if (isPlayer) {
      playerScore += scoreIncrease;
    } else {
      opponentScore += scoreIncrease;
    }
  }
}
