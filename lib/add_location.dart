import 'package:flutter/material.dart';
import 'models/location_model.dart';
import 'blocs/location_block.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'utilities/prefs_helper.dart';

class AddLocationPage extends StatefulWidget {
  AddLocationPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  @override
  Widget build(BuildContext context) {
    locationBloc.fetchAvailableLocation();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Locations Settings'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: StreamBuilder(
          stream: locationBloc.availableLocationList,
          builder: (context, AsyncSnapshot<Map<String, bool>> snapshot) {
            if (snapshot.hasData) {
              return buildLocationList(snapshot.data);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildLocationList(Map<String, bool> availableLocations) {
    var locationKeys = availableLocations.keys.toList();
    locationKeys.sort();
    return ListView.builder(
        itemCount: locationKeys.length,
        itemBuilder: (builder, index) {
          var locationName = locationKeys[index];
          var locationAddedCondition = availableLocations[locationName];
          return GestureDetector(
            child: Container(
              height: 44,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(locationName),),
                  locationAddedCondition
                      ? Container(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),)
                      : Container(),
                ],
              ),
            ),
            onTap: (){
              toggleLocation(locationName);
            },
          );
        });
  }

  void toggleLocation(String location) async{
    List<String> oriLocations = ["Kuala Lumpur", "George Town", "Johor Bahru"];

    if(oriLocations.contains(location)){
      Toast.show("You are not allow to remove $location form the list", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      return;
    }
    updateUserAddedLocations(location);
    setState(() {
      //to refresh the interface
    });

  }
}
