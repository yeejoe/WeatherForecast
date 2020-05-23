import 'package:flutter/material.dart';
import 'package:weatherforecast/models/forecast_weather_model.dart';
import '../models/weather_model.dart';
import '../blocs/weather_bloc.dart';
import '../utilities/methods.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WeatherView extends StatelessWidget {
  static final int UserSelectedLocation = 0;
  static final int UserCurrentLiveLocation = 1;
  int _mode = UserSelectedLocation;
  double locationLon = 0;
  double locationLat = 0;
  String locationName = "";
  DateFormat timeFormatter = DateFormat("MMM dd\nh a");
  WeatherView(this._mode,
      {this.locationLat, this.locationLon, this.locationName});

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
                  return buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
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
            ),
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
      forecastItems.add(createForecastWidget(model));
    });
    return Container(
      height: 110,
      color: Colors.black54,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: forecastItems,
      ),
    );
  }

  Widget createForecastWidget(WeatherModel model) {
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
            timeFormatter.format(weatherTime),
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildList(AsyncSnapshot<WeatherModel> snapshot) {
    WeatherModel weather = snapshot.data;
    print(weather.toString());
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: EdgeInsets.all(48),
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
                        child: topInfo(weather),
                        alignment: Alignment.topCenter,
                      ),
                      Align(
                        child: leftInfo(weather),
                        alignment: Alignment.centerLeft,
                      ),
                      Align(
                        child: rightInfo(weather),
                        alignment: Alignment.centerRight,
                      ),
                      Align(
                        child: weatherImage(weather),
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

  Widget topInfo(WeatherModel model) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              convertKelvintoCelcius(model.main.temp).toStringAsFixed(1),
              style: TextStyle(color: Colors.white, fontSize: 48),
            ),
            Text(
              "°C",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Text(
          "Feels Like ${convertKelvintoCelcius(model.main.feels_like).toStringAsFixed(1)}°C",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget leftInfo(WeatherModel model) {
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Min " +
                    convertKelvintoCelcius(model.main.temp_min)
                        .toStringAsFixed(1),
                style: TextStyle(color: Colors.white),
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
            "Humidity\n${model.main.humidity}%",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget rightInfo(WeatherModel model) {
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
                style: TextStyle(color: Colors.white),
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
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget weatherImage(WeatherModel model) {
    //According to weather cloudy definition, 0-20% is consider sunny, 20-60% is consider partly cloudy, 60%+ is consider cloudy
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
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Wind ${model.wind.speed} m/s",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
