import 'package:flutter/material.dart';

class WeatherErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const WeatherErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.image_not_supported_outlined),
          const SizedBox(height: 20,),
          const Text("Une erreur est survenu"),
          IconButton(onPressed: onRetry, icon: Icon(Icons.restore))
        ],
      ),
    );
  }
}