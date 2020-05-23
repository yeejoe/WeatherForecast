import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../utilities/methods.dart';

class WeatherRightView extends StatelessWidget {
  WeatherModel model;
  WeatherRightView(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Max " +
                    convertKelvintoCelcius(model.main.temp_max)
                        .toStringAsFixed(1),
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
              Text(
                "°C",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            width: 60,
            child: Divider(
              color: Colors.white,
              height: 1,
            ),
          ),
          Text(
            "Pressure\n${model.main.pressure} hPa",
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}
