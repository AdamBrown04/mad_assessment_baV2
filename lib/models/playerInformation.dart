import 'dart:ffi';

class Playerinformation {
  final String playerName;
  late final bool darkMode;
  final int totalGamesPlayed;
  final int totalGamesWon;
  final int totalGamesLost;
  final int totalGamesDrawn;
  final double winRate;
  final int currentWinSteak;
  final int longestWinSteak;

  Playerinformation({
    required this.playerName,
    required this.darkMode,
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

  String getTheme(){
    if (darkMode){
      return "darkTheme";
    } else {
      return "lightTheme";
    }
  }
}