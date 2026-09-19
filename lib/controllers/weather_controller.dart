import 'package:flutter/material.dart';
import 'package:meteo_app/enums/weather_enum.dart';
import 'package:meteo_app/models/weather_model.dart';
import 'package:meteo_app/services/weather_service.dart';

class WeatherController extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherSatus _status = WeatherSatus.initial;
  WeatherModel? _weather;
  String _errorMessage = '';
  final List<String> _searchHistorty = [];

  //getters publique
  WeatherSatus get status => _status;
  WeatherModel? get weather => _weather;
  String get errorMessage => _errorMessage;
  List<String> get searchHistory => List.unmodifiable(_searchHistorty);

  //getters de commodité pour simplifier la vue
  bool get isLoading => _status == WeatherSatus.loading;
  bool get hasData => _status == WeatherSatus.success && _weather != null;
  bool get hasHerror => _status == WeatherSatus.error;

  Future<void> fetchWeather(String cityName) async {
    if (cityName.trim().isEmpty) return;
    _status = WeatherSatus.loading;
    notifyListeners();

    try {
      final result = await _weatherService.fetchWeather(cityName);
      _weather = result;
      _status = WeatherSatus.success;
      _updateSearchHistory(cityName);
    } catch (e) {
      _errorMessage = e.toString();
      _status = WeatherSatus.error;
    } finally {
      notifyListeners();
    }
  }

  void _updateSearchHistory(String cityName) {
    final normalizedCity = cityName.trim();
    //supprimer la ville en dernier position de la liste si elle est de nouveau chercher
    _searchHistorty.removeWhere(
      (city) => city.toLowerCase() == normalizedCity.toLowerCase(),
    );

    //puis la placer en première position de la liste
    _searchHistorty.insert(0, normalizedCity);

    //on garde les 5 dernière ville rechercher
    if (_searchHistorty.length > 5) {
      _searchHistorty.removeLast();
    }
  }
}
