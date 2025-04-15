import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/widgets/gameHistoryScreen.dart';
import 'package:mad_assessment_ba/widgets/themes/applicationThemes.dart';

void main() {
  runApp(const BAScorekeep());
}

class BAScorekeep extends StatelessWidget {
  const BAScorekeep({super.key});
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Gamehistoryscreen(),
      theme: MyThemes().darkTheme,
    );
  }
}
