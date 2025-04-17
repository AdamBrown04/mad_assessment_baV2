import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/navigation/bottomnavbar.dart';
import 'package:mad_assessment_ba/widgets/userSettingsScreen.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return navbar(
        currentIndex: 2,
        body: Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Navigate to settings screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
