import 'package:flutter/material.dart';

class WeatherInitialWidget extends StatelessWidget{
  const WeatherInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.public, size: 100,),
        ],
      ),
    );
  }

}