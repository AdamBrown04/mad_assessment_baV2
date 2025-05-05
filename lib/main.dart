import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/models/playerInformation.dart';
import 'package:mad_assessment_ba/providers/gameDetailsProvider.dart';
import 'package:mad_assessment_ba/providers/playerDetailsProvider.dart';
import 'package:mad_assessment_ba/services/databaseServices.dart';
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
      playerInfo[0] = value.toString(); // Update darkMode value
      await file.writeAsString(playerInfo.join(","));
    } else {
      // Create the file with default values and update darkMode
      final defaultData =
          "false,images/myProfilePic.jpg"; // Default player data
      final playerInfo = defaultData.split(",");
      playerInfo[0] = value.toString(); // Update darkMode value
      await file.writeAsString(playerInfo.join(","));
    }
  }

  Future<void> updatePlayerProfilePicture(String imagePath) async {
    debugPrint("Updating player profile picture to: $imagePath");
    final file = await _localFile;
    if (await file.exists()) {
      final contents = await file.readAsString();
      final playerInfo = contents.split(",");
      playerInfo[1] = imagePath;
      await file.writeAsString(playerInfo.join(","));
    } else {
      final defaultData =
          "false,images/myProfilePic.jpg";
      final playerInfo = defaultData.split(",");
      playerInfo[1] = imagePath;
      await file.writeAsString(playerInfo.join(","));
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
      String contents = await file.readAsString();
      List<String> playerInfo = contents.split(",");
      debugPrint("File contents: $contents");
      return Playerinformation(
        darkMode: playerInfo[0] == "true",
        profilePicture: playerInfo[1],
      );
    } catch (e) {
      return Playerinformation(
        darkMode: false,
        profilePicture: "images/myProfilePic.jpg",
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
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Playerinformation userDetails = snapshot.data!;
            isDarkMode.value = userDetails.darkMode;

            // Use a post-frame callback to update the provider
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Databaseservices.getPlayerInformation(
                Provider.of<PlayerdetailsProvider>(context, listen: false),
              );
              Provider.of<PlayerdetailsProvider>(context, listen: false)
                  .getPlayerProfilePicture();
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
