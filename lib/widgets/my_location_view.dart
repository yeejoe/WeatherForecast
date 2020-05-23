import 'package:flutter/material.dart';
import 'package:weatherforecast/blocs/location_block.dart';
import '../blocs/weather_bloc.dart';
import '../utilities/prefs_helper.dart';

class MyLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child:  Container(
            child: Icon(
              Icons.my_location,
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 16, right: 16),
          ),
    );
  }
}
