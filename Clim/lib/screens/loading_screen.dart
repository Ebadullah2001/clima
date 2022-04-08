import 'dart:convert';
import 'package:clim/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  @override
  void getLocationData() async {

    var weatherData = await WeatherModel().getLocationData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData: weatherData);
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitDoubleBounce(size: 100.0, color: Colors.white),
    );
  }
}
