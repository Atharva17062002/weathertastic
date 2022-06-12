import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weathertastic/services/weather.dart';
import 'package:weathertastic/widgets/reusable_card.dart';
import 'package:weathertastic/widgets/card_layout.dart';
import 'package:weathertastic/screens/search_page.dart';

class Weather extends StatefulWidget {

  final locationWeather;
  Weather({required this.locationWeather});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  WeatherModel weather = WeatherModel();
  late int temperature ;
  late String description ;
  late String climate ;
  var humidity ;
  var pressure ;
  late String cityName ;
  var feelsLike ;
  var windSpeed ;
  var visibility ;

  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void startApp() async {
    WeatherModel weatherModel = WeatherModel() ;
    var weatherData = await weatherModel.getLocationWeather();
    updateUi(weatherData) ;
  }

  void updateUi(dynamic weatherData) async{
    setState(() {
      if(weatherData != null){
        var temp = weatherData['main']['temp'] ;
        temperature = temp.round() ;
        description = weatherData['weather'][0]['description'] ;
        climate = weatherData['weather'][0]['main'] ;
        var feLike = weatherData['main']['feels_like'] ;
        feelsLike = feLike.round() ;
        humidity = weatherData['main']['humidity'] ;
        pressure = weatherData['main']['pressure'] ;
        windSpeed = weatherData['wind']['speed'] ;
        visibility = weatherData['visibility'] ;
        cityName = weatherData['name'] ;
      }else{
        temperature = humidity = pressure = feelsLike = windSpeed = visibility = 0 ;
        description = climate = cityName = 'Loading' ;
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SearchPage() ;
        })) ;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff68A7AD),
      appBar: AppBar(
        leading:
          IconButton(
            onPressed: ()async {
              var weatherData = await weather.getLocationWeather() ;
              updateUi(weatherData) ;
            },
            icon: Icon(FontAwesomeIcons.locationArrow),
          ),
        backgroundColor: Color(0xffE5CB9F),
        title: const Text(
          'Weathertastic',
          style: TextStyle(color: Color(0xff99C4C8)),
        ),
        actions: [
          IconButton(
            onPressed: () async{
              var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
              if(typedName != null) {
                var weatherData = await weather.getCityWeather(typedName) ;
                updateUi(weatherData);
              }
            },
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration:  BoxDecoration(
                  color:  Color(0xff99C4C8),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    Text(
                      'Currently in $cityName',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      temperature.toString()+'\u00B0C',
                      style: const TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      description,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ReusableCard(
                              childWidget: CardLayout(
                                title: 'Feels like',
                                value: '$feelsLike\u00B0C',
                                iconToUse: FontAwesomeIcons.temperatureLow,
                              )
                          ),
                        ),
                        Expanded(
                          child: ReusableCard(
                              childWidget: CardLayout(
                                title: 'Weather Type',
                                value: climate,
                                iconToUse: FontAwesomeIcons.cloudSun,
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ReusableCard(
                              childWidget: CardLayout(
                                title: 'Wind Speed',
                                value: '$windSpeed m/s',
                                iconToUse: FontAwesomeIcons.wind,
                              )
                          ),
                        ),
                        Expanded(
                          child: ReusableCard(
                              childWidget: CardLayout(
                                title: 'Humidity',
                                value: '$humidity%',
                                iconToUse: FontAwesomeIcons.water,
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ReusableCard(
                              childWidget: CardLayout(
                                title: 'Pressure',
                                value: '${pressure}hPa',
                                iconToUse: FontAwesomeIcons.anglesDown,
                              )
                          ),
                        ),
                        Expanded(
                          child: ReusableCard(
                              childWidget: CardLayout(
                                title: 'Visibility',
                                value: '${visibility/1000}km',
                                iconToUse: FontAwesomeIcons.eye,
                              )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

