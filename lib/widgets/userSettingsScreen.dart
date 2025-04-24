import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode"),
                ValueListenableBuilder<bool>(
                  valueListenable: BAScorekeep.isDarkMode,
                  builder: (context, isDark, child) {
                    return Switch(
                      value: isDark,
                      onChanged: (value) {
                        BAScorekeep.isDarkMode.value = value; // Update theme
                        BAScorekeep().updateDarkModePreference(value); // Save to file
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}