class Playerinformation {
  final String playerName = "Player";
  late final bool darkMode;
  bool usePlayerName = false;
  int totalGamesPlayed = 0;
  int totalGamesWon = 0;
  int totalGamesLost = 0;
  int totalGamesDrawn = 0;
  final double winRate = 0.0;
  int currentWinSteak = 0;
  int longestWinSteak = 0;
  String profilePicture;

  Playerinformation({required this.darkMode, required this.profilePicture});

  void updatePlayerInformation({
    required String playerName,
    required bool usePlayerName,
    required int totalGamesPlayed,
    required int totalGamesWon,
    required int totalGamesLost,
    required int totalGamesDrawn,
    required double winRate,
    required int currentWinSteak,
    required int longestWinSteak,
  }) {
    this.usePlayerName = usePlayerName;
    this.totalGamesPlayed = totalGamesPlayed;
    this.totalGamesWon = totalGamesWon;
    this.totalGamesLost = totalGamesLost;
    this.totalGamesDrawn = totalGamesDrawn;
    this.currentWinSteak = currentWinSteak;
    this.longestWinSteak = longestWinSteak;
  }

  double getWinRate(int totalGames, int gamesWon, int gamesDrawn) {
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
