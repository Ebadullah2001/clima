import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:clim/location.dart';
import 'package:clim/services/networking.dart';
const apikey = '831858e8bffaa15627981ccd4c0c7b06';
const apistart ='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {
  Future<dynamic> getNamedLocation(String cityname)async{
    var a = Location();
    await a.getCurrentLocation();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    NetworkHelper networkHelper = NetworkHelper(url:'$apistart?q=$cityname&appid=$apikey&units=metric' );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  Future<dynamic> getLocationData ()async{
    var a = Location();
    await a.getCurrentLocation();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    NetworkHelper networkHelper = NetworkHelper(url:'$apistart?lat=${a.latitude}&lon=${a.longitude}&appid=$apikey&units=metric' );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
