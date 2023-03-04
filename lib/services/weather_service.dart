import 'package:weatherapp/models/weather_data.dart';
import 'package:weatherapp/services/api_service.dart';

import '../resources/constants.dart';

class WeatherService extends ApiService {
  WeatherService();

  Future<WeatherData?> getWeather({
    required double lat,
    required double lon,
  }) async {
    final response = await get("${weatherEndpoint}weather", params: {
      "appid": weatherKey,
      "lat": lat.toString(),
      "lon": lon.toString(),
      "lang": 'en',
      "units": "metric",
      "mode": "json",
    });
    if (response != null) {
      return WeatherData.fromJson(response);
    } else {
      return null;
    }
  }
}