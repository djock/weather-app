class Country {
  final String code;

  Country({required this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'],
    );
  }
}