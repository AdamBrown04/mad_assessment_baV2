import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/navigation/bottomnavbar.dart';
import 'package:mad_assessment_ba/providers/playerDetailsProvider.dart';
import 'package:provider/provider.dart';

class Statspagescreen extends StatefulWidget {
  const Statspagescreen({super.key});

  @override
  State<Statspagescreen> createState() => _StatspagescreenState();
}

class _StatspagescreenState extends State<Statspagescreen> {

  @override
  Widget build(BuildContext context) {
    return navbar(
      currentIndex: 1,
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Statistics",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                  ),
                ),
                SizedBox(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                          SizedBox(height: 20),
                          Text("Games Lost"),
                          SizedBox(height: 10),
                          Text(
                            Provider.of<PlayerdetailsProvider>(context)
                                .totalGamesLost
                                .toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Text("Games Drawn"),
                          SizedBox(height: 10),
                          Text(
                            Provider.of<PlayerdetailsProvider>(context)
                                .totalGamesDrawn
                                .toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Current Win Streak"),
                          SizedBox(height: 10),
                          Text(
                            Provider.of<PlayerdetailsProvider>(context)
                                .currentWinSteak
                                .toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Text("Longest Win Streak"),
                          SizedBox(height: 10),
                          Text(
                            Provider.of<PlayerdetailsProvider>(context)
                                .longestWinSteak
                                .toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
