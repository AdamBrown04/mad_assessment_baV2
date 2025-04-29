import 'package:flutter/material.dart';

class GameDetailsProvider extends ChangeNotifier {
  String playerName = "Player";
  String opponentName = "Opponent";
  String? playerArmy;
  String? opponentArmy;
  String? gameType;
  String? mission;
  String? deploymentType;
  int? playerPoints;
  int? opponentPoints;
  String? deploymentZone;

  void updateGameDetails({
    required String playerName,
    required String opponentName,
    required String? playerArmy,
    required String? opponentArmy,
    required int playerPoints,
    required int opponentPoints,
    required String? gameType,
    required String? mission,
    required String? deploymentType,
    required String? deploymentZone,
  }) {
    this.playerName = playerName;
    this.opponentName = opponentName;
    this.playerArmy = playerArmy;
    this.opponentArmy = opponentArmy;
    this.playerPoints = playerPoints;
    this.opponentPoints = opponentPoints;
    this.gameType = gameType;
    this.mission = mission;
    this.deploymentType = deploymentType;
    this.deploymentZone = deploymentZone;

    notifyListeners(); // Notify listeners of the changes
  }

  void resetGameDetails() {
    playerName = "Player";
    opponentName = "Opponent";
    playerArmy = null;
    opponentArmy = null;
    gameType = null;
    mission = null;
    deploymentType = null;
    deploymentZone = null;
    playerPoints = null;
    opponentPoints = null;

    notifyListeners(); // Notify listeners of the changes
  }
}
