import 'package:flutter/material.dart';

class ColorGradient extends StatelessWidget {
  const ColorGradient({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 255, 230, 0),
            Color.fromARGB(255, 165, 34, 188),
            Color.fromARGB(129, 79, 76, 76),
            
          ],
        ),
      ),
    );
    
  }
}
