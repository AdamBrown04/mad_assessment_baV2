import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/models/playerInformation.dart';
import 'package:mad_assessment_ba/widgets/homeWidgets/gameHistoryScreen.dart';
import 'package:mad_assessment_ba/widgets/homeWidgets/profileScreen.dart';
import 'package:mad_assessment_ba/widgets/homeWidgets/statsPageScreen.dart';
import 'package:mad_assessment_ba/widgets/themes/applicationThemes.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const BAScorekeep());
}

class BAScorekeep extends StatelessWidget {
  const BAScorekeep({super.key});

  static final ValueNotifier<bool> isDarkMode = ValueNotifier(false);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/playerInformation.txt');
  }

  Future<void> updateDarkModePreference(bool value) async {
    final file = await _localFile;
    if (await file.exists()) {
      final contents = await file.readAsString();
      final playerInfo = contents.split(",");
      playerInfo[1] = value.toString(); // Update darkMode value
      await file.writeAsString(playerInfo.join(","));
    } else {
      // Create the file with default values and update darkMode
      final defaultData = "Player,$isDarkMode,0,0,0,0,0.0,0,0"; // Default player data
      final playerInfo = defaultData.split(",");
      playerInfo[1] = value.toString(); // Update darkMode value
      await file.writeAsString(playerInfo.join(","));
    }
  }

  Future<Playerinformation> readPlayerInformation() async {
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
        longestWinSteak: int.parse(playerInfo[8]),
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
        longestWinSteak: 0,
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
      future: readPlayerInformation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          Playerinformation userDetails = snapshot.data!;
          isDarkMode.value = userDetails.darkMode; // Initialize isDarkMode
          return ValueListenableBuilder<bool>(
            valueListenable: isDarkMode,
            builder: (context, isDark, child) {
              return MaterialApp(
                theme: getThemeData(isDark ? "darkTheme" : "lightTheme"),
                initialRoute: '/widgets/gameHistoryScreen',
                routes: {
                  '/widgets/gameHistoryScreen': (context) => Gamehistoryscreen(),
                  '/widgets/statsPageScreen': (context) => Statspagescreen(),
                  '/widgets/profileScreen': (context) => Profilescreen(),
                },
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
