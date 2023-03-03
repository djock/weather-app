class Snow {
  Snow({
    this.the1H = 0,
    this.the3H = 0,
  });

  double the1H;
  double the3H;

  factory Snow.fromJson(Map<String, dynamic> json) => Snow(
    the1H: json["1h"]?.toDouble() ?? 0,
    the3H: json["3h"]?.toDouble() ?? 0,
  );
}