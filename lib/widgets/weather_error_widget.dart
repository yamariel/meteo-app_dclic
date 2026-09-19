import 'package:flutter/material.dart';

class WeatherErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;
  const WeatherErrorWidget({
    super.key,
    required this.onRetry,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 100, color: Colors.redAccent,),
            const SizedBox(height: 20),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16),),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh), 
              label: const Text("Réessayer", style: TextStyle(color: Colors.black),),
            )
          ],
        ),
      ),
    );
  }
}
