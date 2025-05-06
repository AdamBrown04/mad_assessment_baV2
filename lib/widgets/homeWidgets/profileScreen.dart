import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/navigation/bottomnavbar.dart';
import 'package:mad_assessment_ba/providers/playerDetailsProvider.dart';
import 'package:mad_assessment_ba/widgets/userSettingsScreen.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return navbar(
        currentIndex: 2,
        body: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
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
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          Provider.of<PlayerdetailsProvider>(context)
                                      .profilePicture !=
                                  'images/myProfilePic.jpg'
                              ? FileImage(File(
                                  Provider.of<PlayerdetailsProvider>(context)
                                      .profilePicture))
                              : AssetImage('images/myProfilePic.jpg')
                                  as ImageProvider,
                    ),
                    SizedBox(height: 20),
                    Text(
                      Provider.of<PlayerdetailsProvider>(context).playerName,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  children: [
                                    Text("Games Played"),
                                    SizedBox(height: 10),
                                    Text(
                                      Provider.of<PlayerdetailsProvider>(context)
                                          .totalGamesPlayed
                                          .toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Center(
                                child: Column(
                                  children: [
                                    Text("Games Won"),
                                    SizedBox(height: 10),
                                    Text(
                                      Provider.of<PlayerdetailsProvider>(context)
                                          .totalGamesWon
                                          .toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  children: [
                                    Text("Win Rate"),
                                    SizedBox(height: 10),
                                    Text(
                                      Provider.of<PlayerdetailsProvider>(context)
                                          .winRate
                                          .toStringAsFixed(2),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
