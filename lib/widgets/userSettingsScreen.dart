import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/main.dart';
import 'package:mad_assessment_ba/services/databaseServices.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool userConfirmation() {
    bool isConfirmed = false;
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
                isConfirmed = true; // Set the confirmation flag to true
              },
              child: const Text("Reset"),
            ),
          ],
        );
      },
    );
    return isConfirmed;
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
                      Icon(Icons.dark_mode),
                      Text("Dark Mode"),
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
                      userConfirmation();
                    },
                    child: Text("Reset Game History")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
