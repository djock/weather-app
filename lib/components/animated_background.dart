import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';

import '../resources/app_colors.dart';
import '../utils/utils.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground(
      this.weatherType, {
        this.weatherTheme,
        Key? key,
      }) : super(key: key);

  final WeatherType? weatherType;
  final ThemeWeather? weatherTheme;

  @override
  Widget build(BuildContext context) {
    ThemeWeather skyGradient = weatherTheme ?? backgroundWeatherTheme();
    var _weatherType = weatherType;
    //override weather type
    if (alreadyNight) {
      if (_weatherType == WeatherType.sunny) {
        _weatherType = WeatherType.sunnyNight;
      }
      if (_weatherType == WeatherType.cloudy) {
        _weatherType = WeatherType.cloudyNight;
      }
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        if (_weatherType != null)
          Opacity(
            opacity: .5,
            child: WeatherBg(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              weatherType: _weatherType,
            ),
          ),
        if (_weatherType == WeatherType.sunnyNight)
          Opacity(
            opacity: .5,
            child: Image.asset(
              "assets/images/aurora.png",
              height: MediaQuery.of(context).size.height / 1.5,
              fit: BoxFit.cover,
            ),
          ),
        Positioned(
          bottom: 0,
          height: MediaQuery.of(context).size.height,
          child: ShaderMask(
            shaderCallback: const LinearGradient(
              colors: [Colors.transparent, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader,
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(gradient: skyGradient.backround),
              child: Image.asset(
                "assets/images/deer.png",
                height: 150,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                color: skyGradient.deerColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
