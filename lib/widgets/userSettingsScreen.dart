import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/main.dart';
import 'package:mad_assessment_ba/providers/playerDetailsProvider.dart';
import 'package:mad_assessment_ba/services/databaseServices.dart';
import 'package:mad_assessment_ba/widgets/editProfileScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  void userConfirmationGameHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content:
              const Text("Are you sure you want to reset the game history?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Databaseservices.resetDatabase(); // Reset player information
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Reset"),
            ),
          ],
        );
      },
    );
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/playerInformation.txt');
  }
  
  void userConfirmationProfile(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content:
              const Text("Are you sure you want to reset the profile?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final file = _localFile;
                file.then((value) {
                  value.writeAsString("Player,false,0,0,0,0,0.0,0,0");
                });
                Provider.of<PlayerdetailsProvider>(context, listen: false)
                    .resetPlayerDetails(); 
                Navigator.of(context).pop(); 
              },
              child: const Text("Reset"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      BAScorekeep.isDarkMode.value =
                          !BAScorekeep.isDarkMode.value;
                    });
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        size: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Dark Mode",
                            style: TextStyle(fontSize: 17.5),
                          )),
                      Spacer(),
                      ValueListenableBuilder<bool>(
                        valueListenable: BAScorekeep.isDarkMode,
                        builder: (context, isDarkMode, child) {
                          return Switch(
                            value: isDarkMode,
                            onChanged: (value) {
                              setState(() {
                                isDarkMode = value;
                              });
                              BAScorekeep.isDarkMode.value =
                                  value; // Update theme
                              BAScorekeep().updateDarkModePreference(
                                  value); // Save to file
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Editprofilescreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.person_outline, size: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward, size: 30),
                  ],
                ),
              ),
            ),),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      userConfirmationGameHistory();
                    },
                    child: Text("Reset Game History", 
                        style: TextStyle(fontSize: 17.5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      userConfirmationProfile();
                    },
                    child: Text("Reset Profile", 
                        style: TextStyle(fontSize: 17.5))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
