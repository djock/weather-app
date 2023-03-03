class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"]?.toDouble() ?? 0,
    feelsLike: json["feels_like"]?.toDouble() ?? 0,
    tempMin: json["temp_min"]?.toDouble() ?? 0,
    tempMax: json["temp_max"]?.toDouble() ?? 0,
    pressure: json["pressure"] ?? 0,
    humidity: json["humidity"] ?? 0,
    seaLevel: json["sea_level"] ?? 0,
    grndLevel: json["grnd_level"] ?? 0,
  );

  @override
  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "humidity": humidity,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
  };
}