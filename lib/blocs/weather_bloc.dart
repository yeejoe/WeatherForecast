import '../adapter/weather_api.dart';
import 'package:rxdart/rxdart.dart';
import '../models/weather_model.dart';
import '../models/forecast_weather_model.dart';

class WeatherBloc {
  final _api = WeatherApi();
  final weatherFetcher = PublishSubject<WeatherModel>();
  final forecastWeatherFetcher = PublishSubject<ForecastWeatherModel>();

  Stream<WeatherModel> get weatherOfSelectedLocation => weatherFetcher.stream;
  Stream<ForecastWeatherModel> get forecastWeatherOfSelectedLocation => forecastWeatherFetcher.stream;

  fetchWeatherOf(location) async {
    WeatherModel itemModel = await _api.fetchWeatherOf(location);
    weatherFetcher.sink.add(itemModel);
  }
  fetchWeatherOfSelf(double lat, double lon) async{

    WeatherModel itemModel = await _api.fetchCoordWeatherOf(lat, lon);
    weatherFetcher.sink.add(itemModel);
  }
  fetchForecastWeatherOf(location) async {
    ForecastWeatherModel itemModel = await _api.fetchForecastWeatherOf(location);
    forecastWeatherFetcher.sink.add(itemModel);
  }
  fetchForecastWeatherOfSelf(double lat, double lon) async{
    ForecastWeatherModel itemModel = await _api.fetchCoordForecastWeatherOf(lat, lon);
    forecastWeatherFetcher.sink.add(itemModel);
  }
  dispose() {
    weatherFetcher.close();
  }
}

final weatherBloc = WeatherBloc();