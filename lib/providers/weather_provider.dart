import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/weather_data.dart';

import '../resources/constants.dart';
import '../services/weather_service.dart';

///Location provider for getting current location
class WeatherProvider extends ChangeNotifier {
  List<double>? _currentLocation;

  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  void initialize() {
    fetchCurrentLocation();
  }

  ///Get current location
  List<double> get currentLocation => _currentLocation ?? defaultLocation;

  set currentLocation(List<double> value) {
    _currentLocation = value;
    notifyListeners();
  }

  ///Fetch current location and notify listeners
  Future fetchCurrentLocation() async {
    if (await _checkPermission()) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) => [value.latitude, value.longitude]).then((value) {
        _currentLocation = value;
        loadWeather();
      }).catchError((e) {
        loadWeather();
      });

      notifyListeners();
    } else {
      loadWeather();
    }
  }

  ///Checking user's permission and service status
  Future<bool> _checkPermission([bool requested = false]) async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) return false;
    if (permission == LocationPermission.denied) {
      if (requested) return false;
      permission = await Geolocator.requestPermission();
      //Recall this function with requested = true to check permission again
      return _checkPermission(true);
    } else {
      return true;
    }
  }

  void loadWeather() async {
    WeatherService().getWeather(lat: currentLocation.first, lon: currentLocation.last).then((value) {
      _weatherData = value;
      notifyListeners();
    });
  }

  static WeatherProvider read(BuildContext context) => context.read();
  static WeatherProvider watch(BuildContext context) => context.watch();
}
