import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../exceptions/weather_exception.dart';
import '../models/weather_model.dart';

class WeatherService {
  final String _apiKey = dotenv.env['apiKey'] ?? '';
  final String _baseUrl = dotenv.env['baseUrl'] ?? '';

  Future<WeatherModel> fetchWeather(String cityName) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl?q=$cityName&appid=$_apiKey&units=metric&lang=fr',
      );
      final response = await http.get(uri);

      switch (response.statusCode) {
        case 200:
          final jsonMap = jsonDecode(response.body);
          return WeatherModel.fromJson(jsonMap);
        case 401:
          throw WeatherException(
            "Clé API invalide. Vérifiez votre configuration.",
          );
        case 404:
          throw WeatherException(
            "Ville $cityName introuvable. Vérifiez l'orthogrape.",
          );
        case 429:
          throw WeatherException(
            "Limite de requêtes atteintes. Réessayez plus tard.",
          );
        default:
          throw WeatherException("Erreur serveur: (${response.statusCode})");
      }
    } on SocketException {
      throw WeatherException(
        "Erreur de connexion. Vérifiez vote accès à internet.",
      );
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException("Une erruer inattendue est survenue: $e");
    }
  }
}
