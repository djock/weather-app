
import 'package:flutter/material.dart';

import 'divider.dart';

class WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherInfo({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 40),
          const CustomDivider(
            space: 10,
            direction: Axis.vertical,
          ),
          Expanded(
              child: Text(value,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white))
        ],
      ),
    );
  }

}