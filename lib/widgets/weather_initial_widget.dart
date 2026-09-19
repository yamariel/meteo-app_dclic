import 'package:flutter/material.dart';

class WeatherInitialWidget extends StatelessWidget {
  const WeatherInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.public, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Recherchez une ville',
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'pour obtenir la météo en temps réel',
              style: TextStyle(color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}