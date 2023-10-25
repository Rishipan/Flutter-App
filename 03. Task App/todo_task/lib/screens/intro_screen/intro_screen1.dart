import 'package:flutter/material.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.purple.shade100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.shade300,
            Colors.amber.shade100,
          ],
        ),
      ),
      child: const Center(
        child: Text(
          'Screen 1',
        ),
      ),
    );
  }
}
