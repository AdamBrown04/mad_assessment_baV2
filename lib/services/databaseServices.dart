import 'package:mad_assessment_ba/models/gameHistory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databaseservices {
  static Future<Database> _openDatabase() async{
    final database_path = await getDatabasesPath();
    final database_file = join(database_path, 'game_history.db');
    return openDatabase(database_file, version: 1, onCreate: createDatabase);
  }

  static Future<void> createDatabase(Database db, int version) async{
  String sqlGame = "CREATE TABLE IF NOT EXISTS game_history (gameID INTEGER PRIMARY KEY, playerName TEXT, opponentName TEXT, playerPoints INTEGER, opponentPoints INTEGER, playerArmy TEXT, opponentArmy TEXT, dateTime TEXT, isPlayerWinner INTEGER)";
  db.execute(sqlGame);
  }
//database operations for games
  static Future<void> insertGameHistory(Gamehistory gameHistory) async {
    final db = await _openDatabase();
    String sql = "INSERT INTO game_history (gameID, playerName, opponentName, playerPoints, opponentPoints, playerArmy, opponentArmy, dateTime, isPlayerWinner) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    await db.execute(sql, [
      gameHistory.gameID,
      gameHistory.playerName,
      gameHistory.opponentName,
      gameHistory.playerPoints,
      gameHistory.opponentPoints,
      gameHistory.playerArmy,
      gameHistory.opponentArmy,
      gameHistory.playedDay.toIso8601String(),
      gameHistory.isPlayerWinner ? 1 : 0
    ]);
  }

  static Future<Map<String, dynamic>?> getGameHistory(int gameID) async {
    final db = await _openDatabase();
    List<Map<String, dynamic>> result = await db.query('game_history', where: 'gameID = ?', whereArgs: [gameID]);
    return result.isNotEmpty ? result.first : null;
  }

  static Future<List<Map<String, dynamic>>> getAllGameHistory() async {
    final db = await _openDatabase();
    return db.query('game_history');
  }
}