class Wind  {
  Wind({
    this.speed = 0,
    this.deg = 0,
    this.gust = 0,
  });

  double speed;
  int deg;
  double gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"]?.toDouble() ?? 0,
    deg: json["deg"] ?? 0,
    gust: json["gust"]?.toDouble() ?? 0,
  );
}