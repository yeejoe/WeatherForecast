import 'package:flutter/material.dart';
import 'package:weatherforecast/blocs/location_block.dart';
import '../blocs/weather_bloc.dart';
import '../utilities/prefs_helper.dart';

class CurrentLocationView extends StatelessWidget {
  String _locationName = "";
  CurrentLocationView(this._locationName);
  @override
  Widget build(BuildContext context) {
    getData();
    return StreamBuilder(
      stream: locationBloc.currentLocation,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return buildLocation(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void getData() async {
    locationBloc.fetchCurrentLocation();
  }

  Widget buildLocation(String locationName) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.location_searching,
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 16, right: 16),
          ),
          Text(
            this._locationName.isEmpty ? locationName : this._locationName,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
