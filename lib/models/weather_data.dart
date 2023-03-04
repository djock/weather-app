import 'package:weatherapp/models/weather_details/clouds.dart';
import 'package:weatherapp/models/weather_details/coordinates.dart';
import 'package:weatherapp/models/weather_details/main.dart';
import 'package:weatherapp/models/weather_details/snow.dart';
import 'package:weatherapp/models/weather_details/sys.dart';
import 'package:weatherapp/models/weather_details/weather.dart';
import 'package:weatherapp/models/weather_details/wind.dart';

class WeatherData {
  WeatherData({
    required this.coordinates,
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    this.snow,
    this.rain,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  Coordinates coordinates;
  List<Weather> weather;
  Main main;
  int visibility;
  Wind wind;
  Snow? snow;
  Snow? rain;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    coordinates: Coordinates.fromJson(json["coord"]),
    weather: json["weather"] != null ? List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))) : [],
    main: Main.fromJson(json["main"]),
    visibility: json["visibility"],
    wind: Wind.fromJson(json["wind"]),
    snow: json.containsKey("snow") ? Snow.fromJson(json["snow"]) : null,
    rain: json.containsKey("rain") ? Snow.fromJson(json["rain"]) : null,
    clouds: Clouds.fromJson(json["clouds"]),
    dt: json["dt"],
    sys: Sys.fromJson(json["sys"]),
    timezone: json["timezone"],
    id: json["id"],
    name: json["name"],
    cod: json["cod"],
  );
}