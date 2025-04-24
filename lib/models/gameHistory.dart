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
  final int playerScore;
  final int opponentScore;
  final DateTime playedDay;
  bool isPlayerWinner;

  final formattedDate = DateFormat.yMd();

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

  String outputWinner(){
    if(isPlayerWinner){
      return "Victory";
    }
    else{
      return "Loss";
    }
  }
}