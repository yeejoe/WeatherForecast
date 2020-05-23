import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherforecast/widgets/weather_view.dart';
import 'package:weatherforecast/widgets/current_location_view.dart';
import 'package:weatherforecast/widgets/my_location_view.dart';
import 'blocs/location_block.dart';
import 'utilities/prefs_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'add_location.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String _selectedLocation = "";
  int _locationMode = WeatherView.UserSelectedLocation;
  double _locationLat = 0;
  double _locationLon = 0;
  int _current = 0;
  @override
  void initState() {
    setSelectedLocation();
  }

  @override
  Widget build(BuildContext context) {
    locationBloc.fetchLocationList();
    setSelectedLocation();
    return SafeArea(
      child: Scaffold(
          key: _drawerKey, // assign key to Scaffold
          body: Container(
            child: Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: Image.asset(
                    "assets/weather_bg.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                _locationMode == WeatherView.UserCurrentLiveLocation
                    ? WeatherView(
                        _locationMode,
                        locationLat: _locationLat,
                        locationLon: _locationLon,
                      )
                    : carouselWidgetList(),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.black12])),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    child: CurrentLocationView(
                        _locationMode == WeatherView.UserCurrentLiveLocation
                            ? "Current Location"
                            : ""),
                    onTap: locationPressed,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: MyLocationView(),
                    onTap: myLocationPressed,
                  ),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Container(
              child: drawerList(),
              color: Colors.black,
            ),
          )),
    );
  }

  void setSelectedLocation() async {
    _selectedLocation = await getSelectedLocation();
  }

  void locationPressed() {
    setState(() {
      _drawerKey.currentState.openDrawer();
    });
  }

  void myLocationPressed() {
    _locationMode = WeatherView.UserCurrentLiveLocation;
    getCurUseLiveLocation();
  }

  void getCurUseLiveLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _locationLat = position.latitude;
      _locationLon = position.longitude;
    });
  }

  Widget carouselWidgetList() {
    return StreamBuilder(
      stream: locationBloc.locationSelections,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return buildCarousel(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildCarousel(List<String> userLocations) {
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
          child: CarouselSlider.builder(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              initialPage: userLocations.indexOf(_selectedLocation),
              height: height - 52,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                updateSelectedLocation(userLocations[index]);
                setState(() {
                  _current = index;
                });
              },
            ),
            itemCount: userLocations.length,
            itemBuilder: (BuildContext context, int itemIndex) => WeatherView(
              _locationMode,
              locationLat: _locationLat,
              locationLon: _locationLon,
              locationName: userLocations[itemIndex],
            ),
          ),
        ),
        Container(
          color: Colors.black54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: userLocations.map((locationName) {
              int index = userLocations.indexOf(locationName);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.white : Colors.white30,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
    List<Widget> drawerItems = <Widget>[];
    userLocations.forEach((location) {
      drawerItems.add(FlatButton(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  location,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            _selectedLocation == location &&
                    _locationMode == WeatherView.UserSelectedLocation
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            _locationMode = WeatherView.UserSelectedLocation;
            updateSelectedLocation(location);
          });
        },
      ));
    });
  }

  Widget drawerList() {
    return StreamBuilder(
      stream: locationBloc.locationSelections,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return buildDrawer(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildDrawer(List<String> userLocations) {
    List<Widget> drawerItems = <Widget>[];
    userLocations.forEach((location) {
      drawerItems.add(FlatButton(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  location,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            _selectedLocation == location &&
                    _locationMode == WeatherView.UserSelectedLocation
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            _locationMode = WeatherView.UserSelectedLocation;
            updateSelectedLocation(location);
          });
        },
      ));
    });
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: drawerItems,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: FlatButton(
              child: Text(
                "Edit Locations",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (_) => AddLocationPage()));
              },
            ),
          ),
        ]);
  }
}
