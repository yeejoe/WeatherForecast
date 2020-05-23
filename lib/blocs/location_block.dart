import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import '../utilities/prefs_helper.dart';
import 'dart:convert';
import '../models/location_model.dart';


class LocationBloc {
  final userLocationFetcher = PublishSubject<List<String>>();
  Stream<List<String>> get locationSelections => userLocationFetcher.stream;
  final currentLocationFetcher = PublishSubject<String>();
  Stream<String> get currentLocation => currentLocationFetcher.stream;
  final availableLocationListFetcher = PublishSubject<Map<String, bool>>();
  Stream<Map<String, bool>> get availableLocationList => availableLocationListFetcher.stream;

  fetchLocationList() async {
    List<String> oriLocations = ["Kuala Lumpur", "George Town", "Johor Bahru"];
    List<String> userLocations = await getUserAddedLocations();
    oriLocations.addAll(userLocations);
    userLocationFetcher.sink.add(oriLocations);
  }
  fetchCurrentLocation() async{
      var _selectedLocation = await getSelectedLocation();
      currentLocationFetcher.sink.add(_selectedLocation);
  }
  fetchAvailableLocation() async{
    List<String> oriLocations = ["Kuala Lumpur", "George Town", "Johor Bahru"];
    List<String> userLocations = await getUserAddedLocations();
    oriLocations.addAll(userLocations);
    var locationsJsonString = await rootBundle.loadString("assets/locations.json");
    var locations = (jsonDecode(locationsJsonString) as List).map((model) => LocationModel.fromJson(model)).toList();
    Map<String, bool> map = Map<String, bool>();
    locations.forEach((model){
      if(oriLocations.contains(model.city)){
        map[model.city] = true;
      }else{
        map[model.city] = false;
      }
    });
    availableLocationListFetcher.sink.add(map);
  }
  void readLocationList() async{
  }


  dispose() {
    userLocationFetcher.close();
    currentLocationFetcher.close();
  }
}

final locationBloc = LocationBloc();