class Sys {
  Sys({
    this.type = 0,
    this.id = 0,
    required this.country,
    this.sunrise = 0,
    this.sunset = 0,
  });

  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    type: json["type"] ?? 0,
    id: json["id"] ?? 0,
    country: json["country"] ?? "N/A",
    sunrise: json["sunrise"] ?? 0,
    sunset: json["sunset"] ?? 0,
  );
}