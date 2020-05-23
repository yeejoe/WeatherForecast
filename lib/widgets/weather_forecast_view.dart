import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../utilities/methods.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ForecastWeatherView extends StatelessWidget {
  WeatherModel model;
  ForecastWeatherView(this.model);
  DateFormat forecastTimeFormatter = DateFormat("MMM dd\nh a");

  @override
  Widget build(BuildContext context) {
    var weatherTime =
    DateTime.fromMillisecondsSinceEpoch(model.dt * 1000).toLocal();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: CachedNetworkImage(
              imageUrl: formatWeatherSmallIconUrl(model.weather[0].icon),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Text(
            convertKelvintoCelcius(model.main.temp).toStringAsFixed(1) + "°C",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            forecastTimeFormatter.format(weatherTime),
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}
