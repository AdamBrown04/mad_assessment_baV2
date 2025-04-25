import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/models/gameHistory.dart';

class Gamepreviewscreen extends StatefulWidget {
  const Gamepreviewscreen({super.key, required this.gameHistoryID});

  final int gameHistoryID;

  @override
  State<Gamepreviewscreen> createState() => _GamepreviewscreenState();
}

class _GamepreviewscreenState extends State<Gamepreviewscreen> {
  late Gamehistory gameData;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(gameData.playerName),
                      Text(gameData.playerArmy),
                    ],
                  ),
                  Column(
                    children: [
                      Text(gameData.getFormattedDate),
                      Text(
                          "${gameData.playerPoints} vs ${gameData.opponentPoints}"),
                      Text(gameData.outputWinner())
                    ],
                  ),
                  Column(
                    children: [
                      Text(gameData.opponentName),
                      Text(gameData.opponentArmy),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
