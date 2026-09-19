import 'package:flutter/material.dart';
import 'package:meteo_app/utils/weather_utilss.dart';
import 'package:meteo_app/widgets/weather_detail_card.dart';
import 'package:meteo_app/widgets/weather_widgets.dart';
import 'package:provider/provider.dart';

import '../controllers/weather_controller.dart';
import '../enums/weather_enum.dart';
import '../widgets/weather_error_widget.dart';
import '../widgets/weather_initial_widget.dart';
import '../widgets/weather_loading_widget.dart';
import '../widgets/weather_search_bar.dart';

class WeatherViews extends StatefulWidget {
  const WeatherViews({super.key});
  @override
  State<StatefulWidget> createState() => _WeatherViewsState();
}

class _WeatherViewsState extends State<WeatherViews> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Ma météo", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedContainer(
        constraints: const BoxConstraints.expand(),
        duration: const Duration(microseconds: 800),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: WeatherController().weather != null
                ? WeatherUtils.getGradientColors(
                    WeatherController().weather!.iconCode,
                  )
                : [Colors.blue.shade900, Colors.blue.shade300],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Consumer<WeatherController>(
                  builder: (context, controllerState, child) {
                    return WeatherSearchBar(
                      controller: _controller,
                      onSearch: (city) {
                        FocusScope.of(context).unfocus();
                        controllerState.fetchWeather(city);
                      },
                      suggestions: controllerState.searchHistory,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Consumer<WeatherController>(
                  builder: (context, state, child) {
                    if (state.status == WeatherStatus.initial) {
                      return const WeatherInitialWidget();
                    }
                    if (state.isLoading) {
                      return const WeatherLoadingWidget();
                    }
                    if (state.hasError) {
                      return WeatherErrorWidget(
                        onRetry: () => state.fetchWeather(_controller.text), message: state.errorMessage,
                      );
                    }
                    return _weatherDataView(state);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _weatherDataView(WeatherController state) {
  final weather = state.weather;
  if (weather == null) return const SizedBox.shrink();
  final formattedDate = WeatherUtils.formatDate(DateTime.now());
  final weatherIcon = WeatherUtils.getWeatherIcon(weather.iconCode);

  return Column(
    children: [
      WeatherWidgets(
        formattedDate: formattedDate,
        weather: weather,
        weatherIcon: weatherIcon,
      ),
      const SizedBox(height: 30),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          WeatherDetailCard(
            icon: Icons.water_drop,
            label: "Humidité",
            value: "${weather.humidity}%",
            iconColor: Colors.blueAccent,
          ),
          WeatherDetailCard(
            icon: Icons.air,
            label: "Vent",
            value: "${weather.windDegree} m/s NO",
            iconColor: Colors.greenAccent,
          ),
          WeatherDetailCard(
            icon: Icons.speed,
            label: "Pression",
            value: "${weather.pressure} hPa",
            iconColor: Colors.purpleAccent,
          ),
          WeatherDetailCard(
            icon: Icons.visibility,
            label: "Visibilité",
            value: "${weather.visibility / 1000} km",
            iconColor: Colors.orangeAccent,
          ),
        ],
      ),
    ],
  );
}
