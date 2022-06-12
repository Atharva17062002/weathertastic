
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:weathertastic/services/networking.dart';
import 'location.dart';

const apiKey = '2b8d6338a54467c371832d2363397e5c';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel{
  Future<dynamic> getCityWeather(String cityName) async{
    NetworkHelper networkHelper = NetworkHelper( '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getcurrentLocation();
    
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData =await networkHelper.getData();

    return weatherData;
  }
}
