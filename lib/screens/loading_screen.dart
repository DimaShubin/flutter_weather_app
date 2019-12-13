import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '1533e1a1b35b148dc03a79ce6711e71a';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location currentLocation = Location();
    await currentLocation.getCurrentLocation();

    NetworkHelper networkHelper =
        NetworkHelper('https://samples.openweathermap.org/data/2'
            '.5/weather?lat=${currentLocation.latitude}&lon=${currentLocation
            .longitude}&appid=$apiKey');

    var locationWeather = await networkHelper.getData();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen
      (locationWeather: locationWeather)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.00,
        ),
      ),
    );
  }
}