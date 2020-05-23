import 'url_helper.dart';

double convertKelvintoCelcius(double kelvin){
  return kelvin - 273.15;
}

String formatWeatherIconUrl(String iconName){
  print(Weather_Icon_URL+iconName+"@2x.png");
  return Weather_Icon_URL+iconName+"@2x.png";
}
String formatWeatherSmallIconUrl(String iconName){
  print(Weather_Icon_URL+iconName+".png");
  return Weather_Icon_URL+iconName+".png";
}