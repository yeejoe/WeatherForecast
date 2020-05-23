class LocationModel{
  String _city;
  double _lat;
  double _lng;

  LocationModel.fromJson(Map<String, dynamic> data){
    _city = data["city"];
    _lat = double.parse(data["lat"]);
    _lng = double.parse(data["lng"]);
  }

  double get lng => _lng;

  double get lat => _lat;

  String get city => _city;


}