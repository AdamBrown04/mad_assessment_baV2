import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/models/playerInformation.dart';
import 'package:mad_assessment_ba/providers/gameDetailsProvider.dart';
import 'package:mad_assessment_ba/providers/playerDetailsProvider.dart';
import 'package:mad_assessment_ba/services/notification_services.dart';
import 'package:mad_assessment_ba/widgets/homeWidgets/gameHistoryScreen.dart';
import 'package:mad_assessment_ba/widgets/homeWidgets/profileScreen.dart';
import 'package:mad_assessment_ba/widgets/homeWidgets/statsPageScreen.dart';
import 'package:mad_assessment_ba/widgets/themes/applicationThemes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationServices.initializeNotifications();
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
      final defaultData =
          "Player,false,false,0,0,0,0,0.0,0,0,images/myProfilePic.jpg,0"; // Default player data
      final playerInfo = defaultData.split(",");
      playerInfo[1] = value.toString(); // Update darkMode value
      await file.writeAsString(playerInfo.join(","));
    }
  }

  Future<void> updateImageNumber(int imageNumber) async {
    final file = await _localFile;
    if (await file.exists()) {
      final contents = await file.readAsString();
      final playerInfo = contents.split(",");
      playerInfo[11] = imageNumber.toString();
      await file.writeAsString(playerInfo.join(","));
    } else {
      final defaultData =
          "Player,false,false,0,0,0,0,0.0,0,0,images/myProfilePic.jpg,0";
      final playerInfo = defaultData.split(",");
      playerInfo[11] = imageNumber.toString();
      await file.writeAsString(playerInfo.join(","));
    }
  }

  Future<String> getImageNumber() async {
    final file = await _localFile;
    if (await file.exists()) {
      final contents = await file.readAsString();
      final playerInfo = contents.split(",");
      return playerInfo[11];
    } else {
      return "0";
    }
  }

  Future<void> updatePlayerProfilePicture(String imagePath) async {
    final file = await _localFile;
    if (await file.exists()) {
      final contents = await file.readAsString();
      final playerInfo = contents.split(",");

      // Update the profile picture
      playerInfo[10] = imagePath;
      await file.writeAsString(playerInfo.join(","));
      print("Profile picture updated in file: $imagePath");
    } else {
      // Create the file with default values
      final defaultData =
          "Player,false,false,0,0,0,0,0.0,0,0,images/myProfilePic.jpg,0";
      final playerInfo = defaultData.split(",");
      playerInfo[10] = imagePath;
      await file.writeAsString(playerInfo.join(","));
      print("File created with profile picture: $imagePath");
    }
  }

  Future<String> getPlayerProfilePictureFromFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/profile_picture.jpg');
    if (await file.exists()) {
      return file.path;
    } else {
      return "images/myProfilePic.jpg";
    }
  }

  Future<Playerinformation> readPlayerInformation() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        debugPrint("File contents: $contents");
        List<String> playerInfo = contents.split(",");

        if (playerInfo.length < 12) {
          debugPrint("File corrupted. Recreating with default data.");
          final defaultData =
              "Player,false,false,0,0,0,0,0.0,0,0,images/myProfilePic.jpg,0";
          await file.writeAsString(defaultData);
          playerInfo = defaultData.split(",");
        }

        return Playerinformation(
          playerName: playerInfo[0],
          darkMode: playerInfo[1] == "true",
          usePlayerName: playerInfo[2] == "true",
          totalGamesPlayed: int.parse(playerInfo[3]),
          totalGamesWon: int.parse(playerInfo[4]),
          totalGamesLost: int.parse(playerInfo[5]),
          totalGamesDrawn: int.parse(playerInfo[6]),
          winRate: double.parse(playerInfo[7]),
          currentWinSteak: int.parse(playerInfo[8]),
          longestWinSteak: int.parse(playerInfo[9]),
          profilePicture: playerInfo[10],
          imageNumber: int.parse(playerInfo[11]),
        );
      } else {
        debugPrint("File does not exist. Creating with default data.");
        final defaultData =
            "Player,false,false,0,0,0,0,0.0,0,0,images/myProfilePic.jpg,0";
        await file.writeAsString(defaultData);
        final playerInfo = defaultData.split(",");
        return Playerinformation(
          playerName: playerInfo[0],
          darkMode: playerInfo[1] == "true",
          usePlayerName: playerInfo[2] == "true",
          totalGamesPlayed: int.parse(playerInfo[3]),
          totalGamesWon: int.parse(playerInfo[4]),
          totalGamesLost: int.parse(playerInfo[5]),
          totalGamesDrawn: int.parse(playerInfo[6]),
          winRate: double.parse(playerInfo[7]),
          currentWinSteak: int.parse(playerInfo[8]),
          longestWinSteak: int.parse(playerInfo[9]),
          profilePicture: playerInfo[10],
          imageNumber: int.parse(playerInfo[11]),
        );
      }
    } catch (e) {
      debugPrint("Error reading file: $e");
      return Playerinformation(
        playerName: "Player",
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
    }
  }

  Future<void> updatePlayerInformation({
    required String player,
    required bool isDarkMode,
    required int totalGamesPlayed,
    required int totalGamesWon,
    required int totalGamesLost,
    required int totalGamesDrawn,
    required double winRate,
    required int currentWinSteak,
    required int longestWinSteak,
    required bool usePlayerName,
    required String profilePicture,
    required int imageNumber,
  }) async {
    final file = await _localFile;
    if (await file.exists()) {
      debugPrint("Working");
      debugPrint("File exists: ${file.path}");

      final contents = await file.readAsString();
      final playerInfo = contents.split(",");
      playerInfo[0] = player;
      playerInfo[1] = isDarkMode.toString();
      playerInfo[2] = totalGamesPlayed.toString();
      playerInfo[3] = totalGamesWon.toString();
      playerInfo[4] = totalGamesLost.toString();
      playerInfo[5] = totalGamesDrawn.toString();
      playerInfo[6] = winRate.toStringAsFixed(2);
      playerInfo[7] = currentWinSteak.toString();
      playerInfo[8] = longestWinSteak.toString();
      playerInfo[9] = usePlayerName.toString();
      playerInfo[10] = profilePicture;
      playerInfo[11] = imageNumber.toString();

      await file.writeAsString(playerInfo.join(","));
      debugPrint("File contents: ${await file.readAsString()}");
    } else {
      debugPrint("Uh oh");
      final defaultData =
          "Player,$isDarkMode,false,0,0,0,0,0.0,0,0,images/myProfilePic.jpg,0"; // Default player data
      final playerInfo = defaultData.split(",");
      playerInfo[2] = totalGamesPlayed.toString();
      playerInfo[3] = totalGamesWon.toString();
      playerInfo[4] = totalGamesLost.toString();
      playerInfo[5] = totalGamesDrawn.toString();
      playerInfo[6] = winRate.toStringAsFixed(2);
      playerInfo[7] = currentWinSteak.toString();
      playerInfo[8] = longestWinSteak.toString();
      playerInfo[9] = usePlayerName.toString();
      playerInfo[10] = profilePicture;
      playerInfo[11] = imageNumber.toString();

      await file.writeAsString(playerInfo.join(","));
    }
  }

  Future<void> updatePlayerName(String playerName) async {
    final file = await _localFile;
    if (await file.exists()) {
      final contents = await file.readAsString();
      final playerInfo = contents.split(",");
      playerInfo[0] = playerName;
      await file.writeAsString(playerInfo.join(","));
    } else {
      final defaultData =
          "Player,$isDarkMode,false,0,0,0,0,0.0,0,0,images/myProfilePic.jpg,0";
      final playerInfo = defaultData.split(",");
      playerInfo[0] = playerName;
      await file.writeAsString(playerInfo.join(","));
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameDetailsProvider()),
        ChangeNotifierProvider(create: (context) => PlayerdetailsProvider()),
      ],
      child: FutureBuilder<Playerinformation>(
        future: readPlayerInformation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Directionality(
                textDirection: TextDirection.ltr,
                child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            Playerinformation userDetails = snapshot.data!;
            isDarkMode.value = userDetails.darkMode;

            // Use a post-frame callback to update the provider
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<PlayerdetailsProvider>(context, listen: false)
                  .updatePlayerDetails(
                playerName: userDetails.playerName,
                darkMode: isDarkMode.value,
                usePlayerName: userDetails.usePlayerName,
                totalGamesPlayed: userDetails.totalGamesPlayed,
                totalGamesWon: userDetails.totalGamesWon,
                totalGamesLost: userDetails.totalGamesLost,
                totalGamesDrawn: userDetails.totalGamesDrawn,
                winRate: userDetails.winRate,
                currentWinSteak: userDetails.currentWinSteak,
                longestWinSteak: userDetails.longestWinSteak,
                profilePicture: userDetails.profilePicture,
                imageNumber: userDetails.imageNumber,
              );
            });

            return ValueListenableBuilder<bool>(
              valueListenable: isDarkMode,
              builder: (context, isDark, child) {
                return MaterialApp(
                  theme: getThemeData(isDark ? "darkTheme" : "lightTheme"),
                  initialRoute: '/widgets/gameHistoryScreen',
                  routes: {
                    '/widgets/gameHistoryScreen': (context) =>
                        Gamehistoryscreen(),
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
      ),
    );
  }
}
