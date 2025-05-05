import 'package:flutter_test/flutter_test.dart';
import 'package:mad_assessment_ba/models/playerInformation.dart';


void main(){
  Playerinformation playerInfo = Playerinformation(
    playerName: "TestPlayer",
    darkMode: false,
    usePlayerName: false,
    totalGamesPlayed: 0,
    totalGamesWon: 0,
    totalGamesLost: 0,
    totalGamesDrawn: 0,
    winRate: 0.0,
    currentWinSteak: 0,
    longestWinSteak: 0,
    profilePicture: "images/myProfilePic.jpg",
    imageNumber: 0,
  );
  //tests fpr getWinRate function
  test('Test getWinRate with no games played', () {
    expect(playerInfo.getWinRate(0, 0, 0), 0.0);
  });
  test('Test getWinRate with games played', () {
    expect(playerInfo.getWinRate(10, 5, 0), 50.0);
  });
  test('Test getWinRate with games drawn', () {
    expect(playerInfo.getWinRate(10, 5, 5), 100.0);
  });
  test("Test getWinRate with incorrect value", () {
    expect(playerInfo.getWinRate(10, 0, 5), 100.0);
  });

  //tests for incrementGamesPlayed function
  test('Test incrementGamesPlayed', () {
    playerInfo.incrementGamesPlayed();
    expect(playerInfo.totalGamesPlayed, 1);
  });
  test('Test incrementGamesPlayed multiple times', () {
    playerInfo.incrementGamesPlayed();
    playerInfo.incrementGamesPlayed();
    expect(playerInfo.totalGamesPlayed, 2);
  });

  //tests for incrementGamesWon function
  test("Test incrementGamesWon", (){
    playerInfo.incrementGamesWon();
    expect(playerInfo.totalGamesWon, 1);
    expect(playerInfo.currentWinSteak, 1);
    expect(playerInfo.longestWinSteak, 1);
  });
  test("Test incrementGamesWon multiple times", (){
    playerInfo.incrementGamesWon();
    playerInfo.incrementGamesWon();
    expect(playerInfo.totalGamesWon, 2);
    expect(playerInfo.currentWinSteak, 2);
    expect(playerInfo.longestWinSteak, 2);
  });

  //tests for incrementGamesLost function
  test("Test incrementGamesLost", (){
    playerInfo.incrementGamesLost();
    expect(playerInfo.totalGamesLost, 1);
    expect(playerInfo.currentWinSteak, 0);
  });
  test("Test incrementGamesLost multiple times", (){
    playerInfo.incrementGamesLost();
    playerInfo.incrementGamesLost();
    expect(playerInfo.totalGamesLost, 2);
    expect(playerInfo.currentWinSteak, 0);
  });

  //tests for incrementGamesDrawn function
  test("Test incrementGamesDrawn", (){
    playerInfo.incrementGamesDrawn();
    expect(playerInfo.totalGamesDrawn, 1);
    expect(playerInfo.currentWinSteak, 0);
  });
  test("Test incrementGamesDrawn multiple times", (){
    playerInfo.incrementGamesDrawn();
    playerInfo.incrementGamesDrawn();
    expect(playerInfo.totalGamesDrawn, 2);
    expect(playerInfo.currentWinSteak, 0);
  });

  //test resetting currentWinStreak
  test("Test resetting currentWinStreak after a loss", (){
    playerInfo.incrementGamesWon();
    playerInfo.incrementGamesWon();
    playerInfo.incrementGamesLost();
    expect(playerInfo.totalGamesWon, 2);
    expect(playerInfo.totalGamesLost, 1);
    expect(playerInfo.currentWinSteak, 0);
    expect(playerInfo.longestWinSteak, 2);
  });
  test("Test resetting currentWinStreak after a draw", (){
    playerInfo.incrementGamesWon();
    playerInfo.incrementGamesWon();
    playerInfo.incrementGamesDrawn();
    expect(playerInfo.totalGamesWon, 2);
    expect(playerInfo.totalGamesDrawn, 1);
    expect(playerInfo.currentWinSteak, 0);
    expect(playerInfo.longestWinSteak, 2);
  });
  
}