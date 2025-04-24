import 'package:flutter/material.dart';

class GameDetailsProvider extends ChangeNotifier {
  String playerName = "Player";
  String opponentName = "Opponent";
  String? playerArmy;
  String? opponentArmy;
  int? playerPoints;
  int? opponentPoints;

  void updateGameDetails({
    required String playerName,
    required String opponentName,
    required String? playerArmy,
    required String? opponentArmy,
    required int playerPoints,
    required int opponentPoints,
  }) {
    this.playerName = playerName;
    this.opponentName = opponentName;
    this.playerArmy = playerArmy;
    this.opponentArmy = opponentArmy;
    this.playerPoints = playerPoints;
    this.opponentPoints = opponentPoints;

    notifyListeners(); // Notify listeners of the changes
  }
}