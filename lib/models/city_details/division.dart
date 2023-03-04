class Division {
  final String code;
  final int geonameid;

  Division({required this.code, required this.geonameid});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      code: json['code'],
      geonameid: json['geonameid'],
    );
  }
}
