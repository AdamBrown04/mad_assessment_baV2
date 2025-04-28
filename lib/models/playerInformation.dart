class Playerinformation {
  final String playerName;
  late final bool darkMode;
  int totalGamesPlayed;
  int totalGamesWon;
  int totalGamesLost;
  int totalGamesDrawn;
  final double winRate;
  int currentWinSteak;
  int longestWinSteak;

  Playerinformation(
      {required this.playerName,
      required this.darkMode,
      required this.totalGamesPlayed,
      required this.totalGamesWon,
      required this.totalGamesLost,
      required this.totalGamesDrawn,
      required this.winRate,
      required this.currentWinSteak,
      required this.longestWinSteak});

  double getWinRate(int totalGames, int gamesWon,
      int gamesDrawn) {
    if (totalGames == 0) {
      return 0.0;
    } else {
      int conclusiveGames = totalGames - gamesDrawn;
      return (gamesWon / conclusiveGames) * 100;
    }
  }

  void incrementGamesPlayed() {
    totalGamesPlayed++;
  }

  void incrementGamesWon() {
    totalGamesWon++;
    currentWinSteak++;
    if (currentWinSteak > longestWinSteak) {
      longestWinSteak = currentWinSteak;
    }
  }

  void incrementGamesLost() {
    totalGamesLost++;
    currentWinSteak = 0;
  }

  void incrementGamesDrawn() {
    totalGamesDrawn++;
    currentWinSteak = 0;
  }

  String getTheme() {
    if (darkMode) {
      return "darkTheme";
    } else {
      return "lightTheme";
    }
  }
}
