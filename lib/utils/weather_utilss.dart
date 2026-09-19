import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherUtils {
  WeatherUtils._();

  static List<Color> getGradientColors(String iconCode) {
    if (iconCode.contains('n')) {
      return [
        const Color(0xFF0F2027),
        const Color(0xFF203A43),
        const Color(0xFF2C5364),
      ];
    }

    if (iconCode.contains('01')) {
      return [Colors.lightBlue.shade300, Colors.blue.shade600];
    } else if (iconCode.contains('02') ||
        iconCode.contains('03') ||
        iconCode.contains('04')) {
      return [Colors.blueGrey.shade400, Colors.grey.shade700];
    } else if (iconCode.contains('09') ||
        iconCode.contains('10') ||
        iconCode.contains('11')) {
      return [Colors.indigo.shade800, Colors.blueGrey.shade900];
    }

    return [Colors.blue, Colors.lightBlueAccent];
  }

  static Icon getWeatherIcon(String iconCode) {
    const double iconSize = 70.0;

    if (iconCode.contains('01')) {
      return const Icon(Icons.wb_sunny, color: Colors.amber, size: iconSize);
    }
    if (iconCode.contains('02')) {
      return const Icon(
        Icons.cloud_queue,
        color: Colors.white70,
        size: iconSize,
      );
    }
    if (iconCode.contains('03') || iconCode.contains('04')) {
      return const Icon(Icons.cloud, color: Colors.white, size: iconSize);
    }
    if (iconCode.contains('09') || iconCode.contains('10')) {
      return const Icon(
        Icons.water_drop,
        color: Colors.lightBlueAccent,
        size: iconSize,
      );
    }
    if (iconCode.contains('11')) {
      return const Icon(
        Icons.thunderstorm,
        color: Colors.deepPurple,
        size: iconSize,
      );
    }
    if (iconCode.contains('13')) {
      return const Icon(
        Icons.ac_unit,
        color: Colors.cyanAccent,
        size: iconSize,
      );
    }
    if (iconCode.contains('50')) {
      return const Icon(Icons.foggy, color: Colors.grey, size: iconSize);
    }

    return const Icon(Icons.public, color: Colors.white, size: iconSize);
  }

  static String formatTemp(double temp) {
    return '${temp.round()}°C';
  }

  static String formatTime(DateTime dt) {
    return DateFormat('HH:mm').format(dt);
  }

  static String formatDate(DateTime dt) {
    return DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(dt);
  }

  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}
