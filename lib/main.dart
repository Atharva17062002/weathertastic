import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weathertastic/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]) ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppBody(),
    );
  }
}

class AppBody extends StatefulWidget {
  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {

  @override
  void initState() {
    super.initState();
    getLocationData() ;
  }

  void getLocationData() async {

    WeatherModel weatherModel = WeatherModel() ;

    var weatherData = await weatherModel.getLocationWeather() ;

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return Weather(locationWeather: weatherData,) ;
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
