import 'package:shared_preferences/shared_preferences.dart';


Future<String> getSelectedLocation() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String location = prefs.getString("selected_locations");

  if(location != null) {
    return location.isEmpty ? "Kuala Lumpur" : location;
  }else{
    return "Kuala Lumpur";
  }
}

void updateSelectedLocation(String newLocation) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("selected_locations", newLocation);
}

Future<List<String>> getUserAddedLocations() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userLocations = prefs.getStringList("user_locations");
  if(userLocations == null){
    return List<String>();
  }
  return userLocations;
}

void updateUserAddedLocations(String location) async{
  List<String> userLocations = await getUserAddedLocations();
  if(userLocations.contains(location)){
    userLocations.remove(location);
  }else{
    userLocations.add(location);
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("user_locations", userLocations);
}