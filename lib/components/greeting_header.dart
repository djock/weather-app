import 'package:flutter/material.dart';
import 'package:weatherapp/resources/app_colors.dart';

import '../providers/weather_provider.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;

    String greeting;
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 18) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    TextStyle textStyle = Theme.of(context).textTheme.headline6!.copyWith(
        color: dynamicTextColor(),
        fontWeight: FontWeight.bold);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage:
                NetworkImage('https://robohash.org/imtest.png?size=120x120'),
            radius: 30.0,
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting,',
                style: textStyle,
              ),
              Text(
                'Human',
                style: textStyle,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () => WeatherProvider.read(context)
                  .loadWeather(),
              icon: Icon(Icons.refresh,
                  color: dynamicTextColor())),
        ],
      ),
    );
  }
}
