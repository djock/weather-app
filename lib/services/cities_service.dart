import 'package:weatherapp/resources/constants.dart';
import 'package:weatherapp/services/api_service.dart';

import '../models/city.dart';

class CitiesService extends ApiService {
  CitiesService();

  var headers = {
    'X-RapidAPI-Key': citiesKey,
    'X-RapidAPI-Host': 'countries-cities.p.rapidapi.com'
  };

  Future<List<City>> getCities() async {
    final response = await get(citiesEndpoint,
        params: {
          "population": "19000", // just so that we make sure we have ~100 cities
        },
        headers: headers);
    if (response != null) {
      return (response['cities'] as List)
          .map((e) => City.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
