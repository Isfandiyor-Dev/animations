import 'package:flutter/material.dart';

class Darkmode extends StatefulWidget {
  const Darkmode({super.key});

  @override
  State<Darkmode> createState() => _DarkmodeState();
}

class _DarkmodeState extends State<Darkmode> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: 150,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Image.asset(
        "assets/runway.png",
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
