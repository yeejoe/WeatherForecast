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
import 'weather_center_view.dart';
import 'weather_forecast_view.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

class WeatherView extends StatelessWidget {
  static final int UserSelectedLocation = 0;
  static final int UserCurrentLiveLocation = 1;
  int _mode = UserSelectedLocation;
  double locationLon = 0;
  double locationLat = 0;
  String locationName = "";
  WeatherView(this._mode,
      {this.locationLat, this.locationLon, this.locationName}){
    Timer.periodic(Duration(seconds: 1), (timer) {

    });
  }


  @override
  Widget build(BuildContext context) {
    getData();
    return Container(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: weatherBloc.weatherOfSelectedLocation,
              builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
                if (snapshot.hasData) {
                  return buildWeatherInfoView(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 110,
              color: Colors.black54,
              child: StreamBuilder(
              stream: weatherBloc.forecastWeatherOfSelectedLocation,
              builder: (context, AsyncSnapshot<ForecastWeatherModel> snapshot) {
                if (snapshot.hasData) {
                  return buildforecast(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),),
          ),
        ],
      ),
    );
  }

  void getData() async {
    if (_mode == UserCurrentLiveLocation) {
      weatherBloc.fetchWeatherOfSelf(locationLat, locationLon);
      weatherBloc.fetchForecastWeatherOfSelf(locationLat, locationLon);
    } else {
//      String location = await getSelectedLocation();
      weatherBloc.fetchWeatherOf(locationName);
      weatherBloc.fetchForecastWeatherOf(locationName);
    }
  }

  Widget buildforecast(AsyncSnapshot<ForecastWeatherModel> snapshot) {
    List<Widget> forecastItems = [];
    snapshot.data.list.forEach((model) {
      forecastItems.add(ForecastWeatherView(model));
    });
    return ListView(
        scrollDirection: Axis.horizontal,
        children: forecastItems,
    );
  }
  Widget buildWeatherInfoView(AsyncSnapshot<WeatherModel> snapshot) {
    WeatherModel weather = snapshot.data;
    print(weather.toString());
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: EdgeInsets.all(32),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
          child: Stack(
            children: <Widget>[
              Align(
                child: Container(
                  child: Text(
                    "N",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  margin: EdgeInsets.only(top: 3),
                ),
                alignment: Alignment.topCenter,
              ),
              Align(
                child: Container(
                  child: Text(
                    "W",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  margin: EdgeInsets.only(left: 4),
                ),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child: Container(
                  child: Text(
                    "E",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  margin: EdgeInsets.only(right: 6),
                ),
                alignment: Alignment.centerRight,
              ),
              Align(
                child: Container(
                  child: Text(
                    "S",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  margin: EdgeInsets.only(bottom: 2),
                ),
                alignment: Alignment.bottomCenter,
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white54)),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        child: WeatherTopView(weather),
                        alignment: Alignment.topCenter,
                      ),
                      Align(
                        child: WeatherLeftView(weather),
                        alignment: Alignment.centerLeft,
                      ),
                      Align(
                        child: WeatherRightView(weather),
                        alignment: Alignment.centerRight,
                      ),
                      Align(
                        child: WeatherBottomView(),
                        alignment: Alignment.bottomCenter,
                      ),
                      Align(
                        child: WeatherCenterView(weather),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
