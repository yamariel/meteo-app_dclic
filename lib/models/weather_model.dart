class WeatherModel {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDegree;
  final String desciption;
  final String iconCode;
  final int visibility;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.desciption,
    required this.feelsLike,
    required this.iconCode,
    required this.pressure,
    required this.sunrise,
    required this.sunset,
    required this.tempMax,
    required this.tempMin,
    required this.temperature,
    required this.humidity,
    required this.visibility,
    required this.windDegree,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] as String,
      country: json['sys']['country'] as String,
      desciption: json['weather'][0]['description'] as String,
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      iconCode: json['weather'][0]['icon'] as String,
      pressure: json['main']['pressure'] as int,
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        (json['sys']['sunrise'] as int) * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        (json['sys']['sunset'] as int) * 1000,
      ),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      visibility: json['visibility'] as int,
      windDegree: json['wind']['deg'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}
