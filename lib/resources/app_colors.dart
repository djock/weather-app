import 'package:flutter/material.dart';

const Color primaryColor = Colors.blue;
const Color secondaryColor = Colors.lightBlueAccent;
Color get shadowColor => Colors.black.withOpacity(.05);

const Color darkPrimaryColor = primaryColor;

const Color lightBackground = Color(0xffF5F6FA);
const Color darkBackground = Color(0xff202020);

Gradient backgroundWeatherGradient() {
  var now = DateTime.now();
  if (now.hour >= 0 && now.hour < 5) return evening;
  if (now.hour >= 5 && now.hour < 7) return beforeSunRise;
  if (now.hour >= 7 && now.hour < 11) return dawn;
  if (now.hour >= 11 && now.hour < 17) return day;
  if (now.hour >= 17 && now.hour < 19) return candleLight;
  if (now.hour >= 20 && now.hour < 24) return evening;
  return day;
}


Color dynamicTextColor() {
  var now = DateTime.now();
  if (now.hour >= 0 && now.hour < 7) return Colors.white;
  if (now.hour >= 7 && now.hour < 17) return Colors.black;
  if (now.hour >= 17 && now.hour < 24) return Colors.white;
  return Colors.white;
}

LinearGradient get candleLight => const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff966cc3), Color(0xffcba1ab), Color(0xfffecc93)],
);

LinearGradient get beforeSunRise => const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff766bcb), Color(0xffc184c8), Color(0xfffa99c5)],
);

LinearGradient get evening => const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff011439), Color(0xff012c57), Color(0xff046198)],
);

LinearGradient get dawn => const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xffffcfcf), Color(0xffa3d0dc), Color(0xff60cee4)],
);

LinearGradient get day => const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff61b1ea), Color(0xff9fdcf7), Color(0xffb7fcff)],
);

