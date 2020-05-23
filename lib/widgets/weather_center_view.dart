import 'package:flutter/material.dart';
import 'package:weatherforecast/models/forecast_weather_model.dart';
import '../models/weather_model.dart';
import '../blocs/weather_bloc.dart';
import '../utilities/methods.dart';
import 'package:intl/intl.dart';
import 'weather_bottom_view.dart';
import 'weather_right_view.dart';
import 'weather_left_view.dart';
import 'weather_top_view.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

class WeatherCenterView extends StatelessWidget {
  WeatherModel model;
  WeatherCenterView(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: CachedNetworkImage(
            imageUrl: formatWeatherIconUrl(model.weather[0].icon),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          margin: EdgeInsets.only(left: 64, right: 64, top: 64),
        ),
        Text(
          model.weather[0].main,
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
        ),
        Text(
          "Wind ${model.wind.speed} m/s",
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

}
