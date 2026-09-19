import 'package:flutter/material.dart';

import '../models/weather_model.dart';

class WeatherWidgets extends StatelessWidget {
  final WeatherModel weather;
  final String formattedDate;
  final Widget weatherIcon;

  const WeatherWidgets({
    super.key,
    required this.formattedDate,
    required this.weather,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                "${weather.cityName}, ${weather.country}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text(
            formattedDate,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              weatherIcon,
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${weather.temperature.round()}°C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    "Ressenti ${weather.feelsLike.round()}°C",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withValues(alpha: 0.2),
            ),
            child: Text(
              weather.desciption,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.thermostat,
                color: Colors.lightBlueAccent,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                "Min ${weather.tempMin.round()}°C",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(width: 32),
              const Icon(
                Icons.thermostat,
                color: Colors.orangeAccent,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                "Max ${weather.tempMax.round()}°C",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
