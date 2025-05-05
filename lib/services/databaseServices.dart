import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/models/gameHistory.dart';
import 'package:mad_assessment_ba/providers/playerDetailsProvider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databaseservices {
  static Future<Database> _openDatabase() async {
    final database_path = await getDatabasesPath();
    final database_file = join(database_path, 'game_history.db');
    return openDatabase(database_file, version: 1, onCreate: createDatabase);
  }

  static Future<void> createDatabase(Database db, int version) async {
    // Create the game_history table
    String sqlGame = '''
    CREATE TABLE IF NOT EXISTS game_history (
      gameID INTEGER PRIMARY KEY,
      playerName TEXT,
      opponentName TEXT,
      playerPoints INTEGER,
      opponentPoints INTEGER,
      playerArmy TEXT,
      opponentArmy TEXT,
      dateTime TEXT,
      isPlayerWinner INTEGER,
      deploymentType TEXT,
      deploymentZone TEXT,
      gameDescription TEXT,
      gameType TEXT,
      mission TEXT,
      playerScore INTEGER,
      opponentScore INTEGER
    )
  ''';
    await db.execute(sqlGame);

    // Create the player_information table
    String sqlPlayer = '''
    CREATE TABLE IF NOT EXISTS player_information (
      playerID INTEGER PRIMARY KEY,
      playerName TEXT,
      usePlayerName INTEGER,
      totalGamesPlayed INTEGER,
      totalGamesWon INTEGER,
      totalGamesLost INTEGER,
      totalGamesDrawn INTEGER,
      winRate REAL,
      currentWinSteak INTEGER,
      longestWinSteak INTEGER
    )
  ''';
    await db.execute(sqlPlayer);
  }

//database operations for games
  static Future<void> insertGameHistory(Gamehistory gameHistory) async {
    final db = await _openDatabase();
    String sql = '''
    INSERT INTO game_history (gameID, playerName, opponentName, playerPoints, opponentPoints, playerArmy, opponentArmy, dateTime, isPlayerWinner, 
      deploymentType, deploymentZone, gameDescription, gameType, mission, playerScore, opponentScore) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)''';
    await db.execute(sql, [
      gameHistory.gameID,
      gameHistory.playerName,
      gameHistory.opponentName,
      gameHistory.playerPoints,
      gameHistory.opponentPoints,
      gameHistory.playerArmy,
      gameHistory.opponentArmy,
      gameHistory.playedDay.toIso8601String(),
      gameHistory.isPlayerWinner ? 1 : 0,
      gameHistory.deploymentType,
      gameHistory.deploymentZone,
      gameHistory.gameDescription,
      gameHistory.gameType,
      gameHistory.mission,
      gameHistory.playerScore,
      gameHistory.opponentScore,
    ]);
  }

  static Future<Map<String, dynamic>?> getGameHistory(int gameID) async {
    final db = await _openDatabase();
    List<Map<String, dynamic>> result = await db
        .query('game_history', where: 'gameID = ?', whereArgs: [gameID]);
    return result.isNotEmpty ? result.first : null;
  }

  static Future<List<Map<String, dynamic>>> getAllGameHistory() async {
    final db = await _openDatabase();
    return db.query('game_history');
  }

  static Future<void> resetDatabase() async {
    final db = await _openDatabase();
    await db.execute('DROP TABLE IF EXISTS game_history');
    await createDatabase(db, 1);
  }

  static Future<int> getNextGameID() async {
    final db = await _openDatabase();
    final result =
        await db.rawQuery('SELECT MAX(gameID) as maxID FROM game_history');
    final maxID = result.first['maxID'] as int?;
    return (maxID ?? 0) + 1; // If no records exist, start with 1
  }
//player information database operations
  static Future<void> updatePlayerInformation(PlayerdetailsProvider playerInfo, int playerID) async{
    final db = await _openDatabase();
    String sql = '''
    INSERT OR REPLACE INTO player_information (playerID ,playerName, usePlayerName, totalGamesPlayed, totalGamesWon, totalGamesLost, totalGamesDrawn, winRate, currentWinSteak, longestWinSteak) 
    VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?)''';
    await db.execute(sql, [
      playerID,
      playerInfo.playerName,
      playerInfo.usePlayerName ? 1 : 0,
      playerInfo.totalGamesPlayed,
      playerInfo.totalGamesWon,
      playerInfo.totalGamesLost,
      playerInfo.totalGamesDrawn,
      playerInfo.winRate,
      playerInfo.currentWinSteak,
      playerInfo.longestWinSteak,
    ]);
  }

  static Future<void> getPlayerInformation(PlayerdetailsProvider playerDetails) async {
    final db = await _openDatabase();
    List<Map<String, dynamic>> result = await db.query('player_information');

    if (result.isNotEmpty) {
      // Safely cast or parse each field to the desired type
      playerDetails.updatePlayerDetails(
        playerName: result.first['playerName']?.toString() ?? "Player", // Ensure String
        usePlayerName: (result.first['usePlayerName'] as int?) == 1, // Ensure bool
        totalGamesPlayed: (result.first['totalGamesPlayed'] as int?) ?? 0, // Ensure int
        totalGamesWon: (result.first['totalGamesWon'] as int?) ?? 0, // Ensure int
        totalGamesLost: (result.first['totalGamesLost'] as int?) ?? 0, // Ensure int
        totalGamesDrawn: (result.first['totalGamesDrawn'] as int?) ?? 0, // Ensure int
        winRate: (result.first['winRate'] as num?)?.toDouble() ?? 0.0, // Ensure double
        currentWinSteak: (result.first['currentWinSteak'] as int?) ?? 0, // Ensure int
        longestWinSteak: (result.first['longestWinSteak'] as int?) ?? 0, // Ensure int
      );
    } else {
      debugPrint("No player information found in the database.");
    }
  }
}
