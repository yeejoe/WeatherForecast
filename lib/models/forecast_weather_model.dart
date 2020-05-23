import 'weather_model.dart';
class ForecastWeatherModel{
  List<WeatherModel> _list;
  int _cnt;
  ForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    _list = (json['list'] as List).map((model) => WeatherModel.fromJson(model)).toList();
    _cnt = json['cnt'];
  }

  int get cnt => _cnt;

  List<WeatherModel> get list => _list;


}