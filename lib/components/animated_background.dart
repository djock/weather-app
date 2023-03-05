import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';

import '../utils/utils.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground(
    this.weatherType, {
    Key? key,
  }) : super(key: key);

  final WeatherType? weatherType;

  @override
  Widget build(BuildContext context) {
    var weatherType = this.weatherType;
    //override weather type
    if (alreadyNight) {
      if (weatherType == WeatherType.sunny) {
        weatherType = WeatherType.sunnyNight;
      }
      if (weatherType == WeatherType.cloudy) {
        weatherType = WeatherType.cloudyNight;
      }
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        if (weatherType != null)
          Opacity(
            opacity: .5,
            child: WeatherBg(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              weatherType: weatherType,
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
          ),
        )
      ],
    );
  }
}
