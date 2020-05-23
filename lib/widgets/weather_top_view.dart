import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../utilities/methods.dart';

class WeatherTopView extends StatelessWidget {
  WeatherModel model;
  WeatherTopView(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              convertKelvintoCelcius(model.main.temp).toStringAsFixed(1),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              "°C",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Text(
          "Feels Like ${convertKelvintoCelcius(model.main.feels_like).toStringAsFixed(1)}°C",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
