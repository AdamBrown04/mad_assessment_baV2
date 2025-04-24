import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/navigation/bottomnavbar.dart';

class Statspagescreen extends StatelessWidget {
  const Statspagescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return navbar(
      currentIndex: 1,
      body: Scaffold(
        appBar: AppBar(
          title: const Text("Statistics", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
