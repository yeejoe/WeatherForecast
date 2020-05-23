class WeatherModel{
  List<_Weather> _weather;
  _Main _main;
  _Cloud _cloud;
  _Wind _wind;
  String _base;
//  int _visibility;
  int _dt;
//  int _timezone;
//  int _id;
  String _name;
//  int _cod;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    _weather = (json['weather'] as List).map((model) => _Weather.fromJson(model)).toList();
    _main = _Main.fromJson(json['main']);
    _cloud = _Cloud.fromJson(json['clouds']);
    _wind = _Wind.fromJson(json['wind']);
    _base = json['base'];
//    _visibility = json['visibility'];
    _dt = json['dt'];
//    _timezone = json['timezone'];
//    _id = json['id'];
    _name = json['name'];
//    _cod = json['cod'];
  }


  List<_Weather> get weather => _weather;

//  int get cod => _cod;

  String get name => _name;

//  int get id => _id;

//  int get timezone => _timezone;

  int get dt => _dt;

//  int get visibility => _visibility;

  String get base => _base;

  _Cloud get cloud => _cloud;

  _Main get main => _main;

  _Wind get wind => _wind;


}

class _Weather{
//  int _id;
  String _main;
  String _description;
  String _icon;
  _Weather.fromJson(Map<String, dynamic> data) {
//    _id = data['id'];
    _main = data['main'];
    _description = data['description'];
    _icon = data['icon'];
  }

  String get icon => _icon;

  String get description => _description;

  String get main => _main;

//  int get id => _id;


}

class _Main{
  double _temp;
  double _feels_like;
  double _temp_min;
  double _temp_max;
  int _pressure;
  int _humidity;
  _Main.fromJson(Map<String, dynamic> data) {
    _temp = double.parse(data['temp'].toString());
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
    _all = int.parse(data['all'].toString());
  }

  int get all => _all;


}