import 'package:flutter/material.dart';

class PlayerdetailsProvider extends ChangeNotifier{
  String playerName = "Player";
  bool darkMode = false;
  int totalGamesPlayed = 0;
  int totalGamesWon = 0;
  int totalGamesLost = 0;
  int totalGamesDrawn = 0;
  double winRate = 0.0;
  int currentWinSteak = 0;
  int longestWinSteak = 0;

  void updatePlayerDetails({
    required String playerName,
    required bool darkMode,
    required int totalGamesPlayed,
    required int totalGamesWon,
    required int totalGamesLost,
    required int totalGamesDrawn,
    required double winRate,
    required int currentWinSteak,
    required int longestWinSteak,
  }) {
    this.playerName = playerName;
    this.darkMode = darkMode;
    this.totalGamesPlayed = totalGamesPlayed;
    this.totalGamesWon = totalGamesWon;
    this.totalGamesLost = totalGamesLost;
    this.totalGamesDrawn = totalGamesDrawn;
    this.winRate = winRate;
    this.currentWinSteak = currentWinSteak;
    this.longestWinSteak = longestWinSteak;

    notifyListeners(); 
  }

  void resetPlayerDetails() {
    playerName = "Player";
    darkMode = false;
    totalGamesPlayed = 0;
    totalGamesWon = 0;
    totalGamesLost = 0;
    totalGamesDrawn = 0;
    winRate = 0.0;
    currentWinSteak = 0;
    longestWinSteak = 0;

    notifyListeners(); 
  }

  void incrementTotalGamesPlayed() {
    totalGamesPlayed++;
    notifyListeners();
  }

  void incrementTotalGamesWon() {
      totalGamesWon++;
      currentWinSteak++;
      if (currentWinSteak >longestWinSteak) {
        longestWinSteak = currentWinSteak;
      }
      notifyListeners(); 
  }

  void incrementTotalGamesLost() {
      totalGamesLost++;
      currentWinSteak = 0; 
      notifyListeners(); 
  }

  void incrementTotalGamesDrawn() {
      totalGamesDrawn++;
      currentWinSteak = 0;
      notifyListeners(); 
  }

  void updateWinRate() {
    if (totalGamesPlayed > 0) {
      int conclusiveGames = totalGamesPlayed - totalGamesDrawn;
      winRate = (totalGamesWon / conclusiveGames) * 100;
    } else {
      winRate = 0.0;
    }
    notifyListeners(); 
  }
}