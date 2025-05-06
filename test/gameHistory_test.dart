import 'package:flutter_test/flutter_test.dart';
import 'package:mad_assessment_ba/models/gameHistory.dart';

void main() {
  Gamehistory gameHistory = Gamehistory(
    gameID: 1,
    playerName: "TestPlayer",
    opponentName: "Opponent",
    playerPoints: 1250,
    opponentPoints: 1250,
    playerArmy: "Army1",
    opponentArmy: "Army2",
    playedDay: DateTime.utc(2025, 7, 4),
    isPlayerWinner: false,
    deploymentType: "Deployment1",
    deploymentZone: "Zone1",
    gameDescription: "Test Game",
    gameType: "Type1",
    mission: "Mission1",
    playerScore: 10,
    opponentScore: 5,
  );

  // Test for getFormattedDate
  test('Test getFormattedDate', () {
    expect(gameHistory.getFormattedDate, "04/07/2025");
  });
  test("Test getFormattedDate with incorrect date expected", () {
    expect(gameHistory.getFormattedDate, "04/07/2024");
  });

  // Test for find if player won
  test("Test findIfPlayerWon with player win", () {
    gameHistory.playerScore = 10;
    gameHistory.opponentScore = 5;
    gameHistory.findIfPlayerWon();
    expect(gameHistory.isPlayerWinner, true);
  });
  test("Test findIfPlayerWon with player loss", () {
    gameHistory.playerScore = 5;
    gameHistory.opponentScore = 10;
    gameHistory.findIfPlayerWon();
    expect(gameHistory.isPlayerWinner, false);
  });
  test("Test findIfPlayerWon with draw", () {
    gameHistory.playerScore = 10;
    gameHistory.opponentScore = 10;
    gameHistory.findIfPlayerWon();
    expect(gameHistory.isPlayerWinner, false);
  });

  test("Test findIfPlayerWon with incorrect value", () {
    gameHistory.playerScore = 5;
    gameHistory.opponentScore = 5;
    gameHistory.findIfPlayerWon();
    expect(gameHistory.isPlayerWinner, true);
  });

  // Test for outputWinner
  test("Test outputWinner with player win", () {
    gameHistory.isPlayerWinner = true;
    expect(gameHistory.outputWinner(), "Victory");
  });
  test("Test outputWinner with player loss", () {
    gameHistory.isPlayerWinner = false;
    expect(gameHistory.outputWinner(), "Loss");
  });
  test("Test outputWinner with draw", () {
    gameHistory.isPlayerWinner = false;
    gameHistory.playerScore = 10;
    gameHistory.opponentScore = 10;
    expect(gameHistory.outputWinner(), "Draw");
  });
  test("Test outputWinner with player loss but expecting win", () {
    gameHistory.isPlayerWinner = false;
    expect(gameHistory.outputWinner(), "Victory");
  });

  //Test for incrementScore function
  test("Test incrementScore with player score", () {
    gameHistory.incrementScore(true, 4);
    expect(gameHistory.playerScore, 14);
  });
  test("Test incrementScore with opponent score", () {
    gameHistory.incrementScore(false, 3);
    expect(gameHistory.opponentScore, 8);
  });
  test("Test incrementScore with incorrect value", () {
    gameHistory.incrementScore(true, 0);
    expect(gameHistory.playerScore, 14);
  });
}
