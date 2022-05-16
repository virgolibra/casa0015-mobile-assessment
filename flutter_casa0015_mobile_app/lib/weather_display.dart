import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({Key? key, required this.lat, required this.lon}) : super(key: key);
  final double lat;
  final double lon;

  @override
  _WeatherDisplayState createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  String key = 'f03bed1c4ee9ac0e28a580ad73ff263d';
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  // double? lat, lon;

  // double? autoLat, autoLon;

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


    queryWeather();

  }



  void queryWeather() async {
    // /// Removes keyboard
    // FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });
    log("Starting Fetch weather");
    Weather weather = await ws.currentWeatherByLocation(widget.lat, widget.lon);
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

    log("Weather Fetching Done!");
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



  // Widget _coordinateInputs() {
  //   return Row(
  //     children: <Widget>[
  //       Expanded(
  //         child: Container(
  //             margin: EdgeInsets.all(5),
  //             child: TextField(
  //                 decoration: InputDecoration(
  //                     border: OutlineInputBorder(), hintText: 'Enter latitude'),
  //                 keyboardType: TextInputType.number,
  //                 onChanged: _saveLat,
  //                 onSubmitted: _saveLat)),
  //       ),
  //       Expanded(
  //           child: Container(
  //               margin: EdgeInsets.all(5),
  //               child: TextField(
  //                   decoration: InputDecoration(
  //                       border: OutlineInputBorder(),
  //                       hintText: 'Enter longitude'),
  //                   keyboardType: TextInputType.number,
  //                   onChanged: _saveLon,
  //                   onSubmitted: _saveLon)))
  //     ],
  //   );
  // }

  // Widget _buttons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         margin: EdgeInsets.all(5),
  //         child: TextButton(
  //           child: Text(
  //             'Fetch weather',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           onPressed: queryWeather,
  //           style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.all(Colors.blue)),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget weatherIconNull() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Center(child: CircularProgressIndicator(strokeWidth: 5)));
  }

  Widget weatherIconNotNull() {
    return SizedBox(
      height: 100,
      width: 100,
      child: Image(
          image: NetworkImage(
              'http://openweathermap.org/img/wn/$_weatherIcon@4x.png')),
    );
  }

  Widget _weatherIconDisplay() =>
      _weatherIcon == null ? weatherIconNull() : weatherIconNotNull();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView(
        children: <Widget>[
          // _coordinateInputs(),
          // _buttons(),
          Text(
            'Output:',
            style: TextStyle(fontSize: 20),
          ),
          Divider(
            height: 20.0,
            thickness: 2.0,
          ),
          SizedBox(height: 200,child: _resultView()),
          Divider(
            height: 20.0,
            thickness: 2.0,
          ),
          Text(
            'Lat: ${widget.lat}',
            style: TextStyle(fontSize: 15),
          ),
          Text(
            'Lon: ${widget.lon}',
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
            'Weather: $_weatherDescription',
            style: TextStyle(fontSize: 15),
          ),
          Text(
            'icon: $_weatherIcon Code: $_weatherConditionCode',
            style: TextStyle(fontSize: 15),
          ),
          _weatherIconDisplay(),
          // Expanded(child: _weatherIconDisplay()),
        ],
      ),
    );
  }


}
