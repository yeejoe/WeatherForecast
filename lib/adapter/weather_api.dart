import 'dart:async';
import '../providers/weather_provider.dart';
import '../models/weather_model.dart';
import '../models/forecast_weather_model.dart';

class WeatherApi {
  final weatherProvider = WeatherProvider();
  Future<WeatherModel> fetchWeatherOf(location) => weatherProvider.fetchWeather(location);
  Future<WeatherModel> fetchCoordWeatherOf(lat, lon) => weatherProvider.fetchCoordWeather(lat, lon);
  Future<ForecastWeatherModel> fetchForecastWeatherOf(location) => weatherProvider.fetchForecastWeather(location);
  Future<ForecastWeatherModel> fetchCoordForecastWeatherOf(lat, lon) => weatherProvider.fetchCoordForecastWeather(lat, lon);
}