
import 'package:flutter/material.dart';
import 'package:weatherapp/services/cities_service.dart';

import '../models/city.dart';

class CitiesProvider extends ChangeNotifier {
  List<City> _cities = [];

  List<City> get cities => _cities;

  set cities(List<City> value) {
    _cities = value;
    notifyListeners();
  }

  void loadCities() async {
    CitiesService().getCities().then((value) {
      _cities = value;
      notifyListeners();
    });
  }
}