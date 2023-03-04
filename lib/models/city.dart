import 'city_details/country.dart';
import 'city_details/division.dart';

class City {
  final int geonameid;
  final int population;
  final String name;
  final double latitude;
  final double longitude;
  final Country country;
  final Division division;

  City({
    required this.geonameid,
    required this.population,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.division,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      geonameid: json['geonameid'],
      population: json['population'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      country: Country.fromJson(json['country']),
      division: Division.fromJson(json['division']),
    );
  }
}