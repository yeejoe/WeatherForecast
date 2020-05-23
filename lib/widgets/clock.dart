import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatelessWidget {
  DateFormat timeOnlyFormatter = DateFormat("h:mm a");

  final now = DateTime.now();
  Stream<DateTime> clock;
  Clock(){
    clock = Stream<DateTime>.periodic(const Duration(seconds: 1), (count) {
      return now.add(Duration(seconds: count));
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: clock,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return
            Text(
              timeOnlyFormatter.format(now),
              style: TextStyle(
                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300),
            );
        }
        return Text(
          timeOnlyFormatter.format(now),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300),
        );
      },
    );
  }
}