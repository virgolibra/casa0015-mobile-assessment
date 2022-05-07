import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String key = 'f03bed1c4ee9ac0e28a580ad73ff263d';
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double? lat, lon;

  double? autoLat, autoLon;

  String? _weatherDescription;
  String? _areaName;
  String? _country;
  double? _humidity;
  double? _pressure;
  // late LatLng _userCurrentPosition;
  double? _temperature;
  double? _tempMin;
  double? _tempMax;
  double? _tempFeelsLike;

  int? _weatherConditionCode;
  String? _weatherIcon;


  @override
  void initState() {
    super.initState();
    ws = new WeatherFactory(key);
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    log("sdsddssssssssss $position");

    // List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      // _userCurrentPosition = LatLng(position.latitude, position.longitude);
      // print('${placemark[0].name}');

      autoLat = position.latitude;
      autoLon = position.longitude;
    });
  }

  void queryForecast() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByLocation(lat!, lon!);
    // Weather weather = await ws.currentWeatherByLocation(lat!, lon!);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
      _temperature = weather.temperature?.celsius;
      _tempMax = weather.tempMax?.celsius;
      _tempMin = weather.tempMin?.celsius;
      _tempFeelsLike = weather.tempFeelsLike?.celsius;
      _humidity = weather.humidity;
      _areaName = weather.areaName;
      _country = weather.country;
      _pressure = weather.pressure;
      _weatherDescription = weather.weatherDescription;
      _weatherConditionCode = weather.weatherConditionCode;
      _weatherIcon = weather.weatherIcon;
    });
  }

  // void queryForecast() async {
  //   /// Removes keyboard
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   setState(() {
  //     _state = AppState.DOWNLOADING;
  //   });
  //
  //   List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat!, lon!);
  //   setState(() {
  //     _data = forecasts;
  //     _state = AppState.FINISHED_DOWNLOADING;
  //   });
  // }

  void queryWeather() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByLocation(autoLat!, autoLon!);
    // Weather weather = await ws.currentWeatherByLocation(lat!, lon!);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
      _temperature = weather.temperature?.celsius;
      _tempMax = weather.tempMax?.celsius;
      _tempMin = weather.tempMin?.celsius;
      _tempFeelsLike = weather.tempFeelsLike?.celsius;
      _humidity = weather.humidity;
      _areaName = weather.areaName;
      _country = weather.country;
      _pressure = weather.pressure;
      _weatherDescription = weather.weatherDescription;
      _weatherConditionCode = weather.weatherConditionCode;
      _weatherIcon = weather.weatherIcon;
    });
  }

  Widget contentFinishedDownload() {
    return Center(
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_data[index].toString()),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(children: [
        Text(
          'Fetching Weather...',
          style: TextStyle(fontSize: 20),
        ),
        Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Press the button to download the Weather forecast',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();

  void _saveLat(String input) {
    lat = double.tryParse(input);
    print(lat);
  }

  void _saveLon(String input) {
    lon = double.tryParse(input);
    print(lon);
  }

  Widget _coordinateInputs() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: EdgeInsets.all(5),
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter latitude'),
                  keyboardType: TextInputType.number,
                  onChanged: _saveLat,
                  onSubmitted: _saveLat)),
        ),
        Expanded(
            child: Container(
                margin: EdgeInsets.all(5),
                child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter longitude'),
                    keyboardType: TextInputType.number,
                    onChanged: _saveLon,
                    onSubmitted: _saveLon)))
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child: TextButton(
            child: Text(
              'Fetch weather',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: queryWeather,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: TextButton(
            child: Text(
              'Fetch forecast',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: queryForecast,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Example App'),
        ),
        body: Column(
          children: <Widget>[
            _coordinateInputs(),
            _buttons(),
            Text(
              'Output:',
              style: TextStyle(fontSize: 20),
            ),
            Divider(
              height: 20.0,
              thickness: 2.0,
            ),
            Expanded(child: _resultView()),
            Divider(
              height: 20.0,
              thickness: 2.0,
            ),
            Text(
              'Lat: $autoLat',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Lon: $autoLon',
              style: TextStyle(fontSize: 15),
            ),
            Divider(
              height: 20.0,
              thickness: 2.0,
            ),
            Text(
              'Temp: ${_temperature?.toStringAsFixed(1)} Min: ${_tempMin?.toStringAsFixed(1)} '
                  'Max: ${_tempMax?.toStringAsFixed(1)} FeelLike: ${_tempFeelsLike?.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Humidity: $_humidity Pressure: $_pressure',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'AreaName: $_areaName Country: $_country',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Weather: $_weatherDescription' ,
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'icon: $_weatherIcon Code: $_weatherConditionCode',
              style: TextStyle(fontSize: 15),
            ),
             Image(
              image: NetworkImage('http://openweathermap.org/img/wn/$_weatherIcon@2x.png'),

            )
          ],
        ),
      ),
    );
  }
}
