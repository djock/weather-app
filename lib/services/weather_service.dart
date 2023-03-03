import 'package:weatherapp/models/weather_response.dart';
import 'package:weatherapp/services/api_service.dart';

import '../resources/constants.dart';

class WeatherService extends ApiService {
  WeatherService(super.context);

  Future<WeatherResponse?> getWeather({
    String units = "metric",
    required double lat,
    required double lon,
    String lang = "en",
  }) async {
    final response = await get("weather", params: {
      "appid": weatherKey,
      "lat": lat.toString(),
      "lon": lon.toString(),
      "lang": lang,
      "units": "metric",
      "mode": "json",
    });
    if (response != null) {
      return WeatherResponse.fromJson(response);
    } else {
      return null;
    }
  }

}