import 'dart:ffi';

class Playerinformation {
  String platerName;
  String playerID;
  int totalGamesPlayed;
  int totalGamesWon;
  int totalGamesLost;
  int totalGamesDrawn;
  double winRate;
  int currentWinSteak;
  int longestWinSteak;

  Playerinformation({
    required this.platerName,
    required this.playerID,
    required this.totalGamesPlayed,
    required this.totalGamesWon,
    required this.totalGamesLost,
    required this.totalGamesDrawn,
    required this.winRate,
    required this.currentWinSteak,
    required this.longestWinSteak
  });

  double getWinRate(){
    if (totalGamesPlayed == 0){
      return 0.0;
    } else {
      int conclusiveGames = totalGamesPlayed - totalGamesDrawn;
      return (totalGamesWon / conclusiveGames) * 100;
    }
  }
}