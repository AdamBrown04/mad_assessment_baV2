import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/models/playerInformation.dart';
import 'package:mad_assessment_ba/widgets/gameHistoryScreen.dart';
import 'package:mad_assessment_ba/widgets/themes/applicationThemes.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const BAScorekeep());
}

class BAScorekeep extends StatelessWidget {
  const BAScorekeep({super.key});
  //File handling code is originally from https://docs.flutter.dev/cookbook/persistence/reading-writing-files, code has been modified when needed to fit personal use
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/playerInformation.txt');
  }

  Future<File> writePlayerInformation(Playerinformation playerDetails) async{
    final file = await _localFile;
    String playerInfo = "${playerDetails.playerName},${playerDetails.darkMode},${playerDetails.totalGamesPlayed}, ${playerDetails.totalGamesWon},${playerDetails.totalGamesLost},${playerDetails.totalGamesDrawn},${playerDetails.winRate},${playerDetails.currentWinSteak},${playerDetails.longestWinSteak}";
    return file.writeAsString(playerInfo);
  }

  Future<Playerinformation> readPlayerInformation() async{
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      List<String> playerInfo = contents.split(",");
      return Playerinformation(
        playerName: playerInfo[0],
        darkMode: playerInfo[1] == "true",
        totalGamesPlayed: int.parse(playerInfo[2]),
        totalGamesWon: int.parse(playerInfo[3]),
        totalGamesLost: int.parse(playerInfo[4]),
        totalGamesDrawn: int.parse(playerInfo[5]),
        winRate: double.parse(playerInfo[6]),
        currentWinSteak: int.parse(playerInfo[7]),
        longestWinSteak: int.parse(playerInfo[8])
      );
    } catch (e) {
      return Playerinformation(
        playerName: "Player",
        darkMode: false,
        totalGamesPlayed: 0,
        totalGamesWon: 0,
        totalGamesLost: 0,
        totalGamesDrawn: 0,
        winRate: 0.0,
        currentWinSteak: 0,
        longestWinSteak: 0
      );
    }
  }

  ThemeData getThemeData(String theme) {
    if (theme == "darkTheme") {
      return MyThemes().darkTheme;
    } else {
      return MyThemes().lightTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Playerinformation>(
      future: readPlayerInformation(), // Fetch the player information asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the data
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle errors
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          // Data is available, use it to build the UI
          Playerinformation userDetails = snapshot.data!;
          return MaterialApp(
            home: Gamehistoryscreen(),
            theme: getThemeData(userDetails.getTheme()),
          );
        } else {
          // Handle the case where there's no data
          return Center(child: Text('No data available'));
        }
      },
    );
  }
  
}
