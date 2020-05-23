import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'clock.dart';

class WeatherBottomView extends StatelessWidget {
  DateFormat dateOnlyFormatter = DateFormat("MMM dd");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            dateOnlyFormatter.format(DateTime.now()),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          Clock(),
        ],
      ),
    );
  }
}
