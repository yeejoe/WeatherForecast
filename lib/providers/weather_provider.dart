import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/weather_model.dart';
import '../models/forecast_weather_model.dart';
import '../utilities/url_helper.dart';

class WeatherProvider {
  Client client = Client();
  final _apiKey = 'e86bf40087be1e52116c2c02d70f702e';

  Future<WeatherModel> fetchWeather(String location) async {
    final response = await client
        .get(Weather_API_URL+"data/2.5/weather?q=$location&APPID=$_apiKey");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  Future<WeatherModel> fetchCoordWeather(double lat, double lon) async {
    final response = await client
        .get(Weather_API_URL+"data/2.5/weather?lat=$lat&lon=$lon&APPID=$_apiKey");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  Future<ForecastWeatherModel> fetchForecastWeather(String location) async {
    final response = await client
        .get(Weather_API_URL+"data/2.5/forecast?q=$location&APPID=$_apiKey");
    print("data forecast:${response.body}");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      return ForecastWeatherModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  Future<ForecastWeatherModel> fetchCoordForecastWeather(double lat, double lon) async {
    final response = await client
        .get(Weather_API_URL+"data/2.5/forecast?lat=$lat&lon=$lon&APPID=$_apiKey");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ForecastWeatherModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}