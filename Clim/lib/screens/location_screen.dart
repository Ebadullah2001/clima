import 'package:clim/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.weatherData});

  final weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  WeatherModel weathermodel = WeatherModel();
  late int temperature;
  late int condition;
  late String cityname;
  late String weathermessage;
  late String weahtherIcon;
  // late String typedname;

  void initState() {
    // TODO: implement initState
    super.initState();
    getUpdate(widget.weatherData);
  }

  void getUpdate(dynamic w) {
    setState(() {
      if (w == null) {
        temperature = 0;
        weahtherIcon = "Error";
        weathermessage = "unable to get message";
        cityname = "";
        return; //it will end it here not go further down
      }
      double temp = w['main']['temp'];
      temperature = temp.toInt();
      condition = w['weather'][0]['id'];
      weahtherIcon = weathermodel.getWeatherIcon(condition);
      cityname = w['name'];
      weathermessage = weathermodel.getMessage(temp.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://c1.wallpaperflare.com/preview/196/882/369/a-drop-of-water-zen-nature.jpg'),
                 fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () async{
                      var weatherdata=await weathermodel.getLocationData();
                      getUpdate(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.black,

                    onPressed: () async{
                      var typedname = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if(typedname!=null){
                        var weatherdata=await weathermodel.getNamedLocation(typedname);
                        getUpdate(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,

                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0,),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weahtherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weathermessage is $cityname!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


