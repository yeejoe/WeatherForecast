class WeatherModel{
  List<_Weather> _weather;
  _Main _main;
  _Cloud _cloud;
  _Wind _wind;
  _Sys _sys;
  String _base;
  int _visibility;
  int _dt;
  int _timezone;
  int _id;
  String _name;
  int _cod;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    _weather = (json['weather'] as List).map((model) => _Weather.fromJson(model)).toList();
    _main = _Main.fromJson(json['main']);
    _cloud = _Cloud.fromJson(json['clouds']);
    _wind = _Wind.fromJson(json['wind']);
    _sys = _Sys.fromJson(json['sys']);
    _base = json['base'];
    _visibility = json['visibility'];
    _dt = json['dt'];
    _timezone = json['timezone'];
    _id = json['id'];
    _name = json['name'];
    _cod = json['cod'];
  }


  List<_Weather> get weather => _weather;

  int get cod => _cod;

  String get name => _name;

  int get id => _id;

  int get timezone => _timezone;

  int get dt => _dt;

  int get visibility => _visibility;

  String get base => _base;

  _Sys get sys => _sys;

  _Cloud get cloud => _cloud;

  _Main get main => _main;

  _Wind get wind => _wind;


}

class _Coordinate{
  double _lon;
  double _lat;

  _Coordinate.fromJson(Map<String, dynamic> data) {
    _lon = data['lon'];
    _lat = data['lat'];
  }

  double get lat => _lat;

  double get lon => _lon;

  @override
  String toString() {
    return '_Coordinate{_lon: $_lon, _lat: $_lat}';
  }


}

class _Weather{
  int _id;
  String _main;
  String _description;
  String _icon;
  _Weather.fromJson(Map<String, dynamic> data) {
    _id = data['id'];
    _main = data['main'];
    _description = data['description'];
    _icon = data['icon'];
  }

  String get icon => _icon;

  String get description => _description;

  String get main => _main;

  int get id => _id;

  @override
  String toString() {
    return '_Weather{_id: $_id, _main: $_main, _description: $_description, _icon: $_icon}';
  }


}

class _Main{
  double _temp;
  double _feels_like;
  double _temp_min;
  double _temp_max;
  int _pressure;
  int _humidity;
  _Main.fromJson(Map<String, dynamic> data) {
    _temp = data['temp'];
    _feels_like = double.parse(data['feels_like'].toString());
    _temp_min = double.parse(data['temp_min'].toString());
    _temp_max = double.parse(data['temp_max'].toString());
    _pressure = int.parse(data['pressure'].toString());
    _humidity = int.parse(data['humidity'].toString());
  }

  int get humidity => _humidity;

  int get pressure => _pressure;

  double get temp_max => _temp_max;

  double get temp_min => _temp_min;

  double get feels_like => _feels_like;

  double get temp => _temp;

  @override
  String toString() {
    return '_Main{_temp: $_temp, _feels_like: $_feels_like, _temp_min: $_temp_min, _temp_max: $_temp_max, _pressure: $_pressure, _humidity: $_humidity}';
  }


}

class _Sys{
  int _type;
  int _id;
  String _country;
  int _sunrise;
  int _sunset;
  _Sys.fromJson(Map<String, dynamic> data) {
    _type = data['type'];
    _id = data['id'];
    _country = data['country'];
    _sunrise = data['sunrise'];
    _sunset = data['sunset'];
  }

  int get sunset => _sunset;

  int get sunrise => _sunrise;

  String get country => _country;

  int get id => _id;

  int get type => _type;

  @override
  String toString() {
    return '_Sys{_type: $_type, _id: $_id, _country: $_country, _sunrise: $_sunrise, _sunset: $_sunset}';
  }


}

class _Wind{
  double _speed;
  _Wind.fromJson(Map<String, dynamic> data) {
    _speed = double.parse(data['speed'].toString());
  }

  double get speed => _speed;

}

class _Cloud{
  int _all;

  _Cloud.fromJson(Map<String, dynamic> data) {
    _all = data['all'];
  }

  int get all => _all;

  @override
  String toString() {
    return '_Cloud{_all: $_all}';
  }


}