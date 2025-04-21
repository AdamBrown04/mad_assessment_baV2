import 'package:intl/intl.dart';

class Gamehistory {
  final int gameID;
  final String playerName;
  final String opponentName;
  final int playerPoints;
  final int opponentPoints;
  final String playerArmy;
  final String opponentArmy;
  final DateTime dateTime;
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
    required this.dateTime,
    required this.isPlayerWinner,
  });

  String get getFormattedDate {
    return formattedDate.format(dateTime);
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