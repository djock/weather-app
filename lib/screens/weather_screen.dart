import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/components/divider.dart';
import 'package:weatherapp/models/weather_response.dart';
import 'package:weatherapp/utils/extensions.dart';

import '../components/animated_background.dart';
import '../providers/weather_provider.dart';
import '../resources/app_colors.dart';
import '../utils/utils.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, value, child) {
        var openWeather = value.weatherResponse;
        return Container(
          decoration: BoxDecoration(gradient: backgroundWeatherTheme().backround),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedBackground(openWeather?.weather.first.weatherType),
                if (openWeather != null)
                  SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                IconButton(onPressed: () => WeatherProvider.read(context).fetchCurrentLocation(context), icon: const Icon(Icons.gps_fixed, color: Colors.white)),
                                Expanded(
                                  child: Text(
                                    openWeather.name,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(onPressed: () => WeatherProvider.read(context).loadWeather(context), icon: const Icon(Icons.refresh, color: Colors.white)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                              children: [
                                _weatherDetail(context, openWeather),
                                const CustomDivider(space: 20, direction: Axis.vertical,),
                                GridView(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5, mainAxisSpacing: 10, crossAxisSpacing: 10),
                                    children: [
                                      _boxItemWidget(
                                        Icons.wind_power,
                                        "Wind",
                                        "${openWeather.wind.speed.toStringAsFixed(1)} m/s",
                                        "Wind Deg : ${openWeather.wind.deg}°",
                                      ),
                                      _boxItemWidget(
                                        Icons.sunny_snowing,
                                        "Sunrise",
                                        DateFormat.Hm().format(unixToDateTime(openWeather.sys.sunrise) ?? DateTime.now()),
                                        "Sunset will be at : ${DateFormat.Hm().format(unixToDateTime(openWeather.sys.sunset) ?? DateTime.now())}",
                                      ),
                                      _boxItemWidget(
                                        Icons.water_drop,
                                        "Humidity",
                                        "${openWeather.main.humidity}%",
                                        "Pressure : ${openWeather.main.pressure} hPa",
                                      ),
                                      _boxItemWidget(
                                        Icons.cloud,
                                        "Clouds",
                                        "${openWeather.clouds.all}%",
                                        "Visibility : ${openWeather.visibility / 1000} km",
                                      ),

                                      //Conditional rain and snow
                                      if (openWeather.rain != null)
                                        _boxItemWidget(
                                          Icons.water,
                                          "Rain",
                                          "${openWeather.rain?.the1H ?? 0} mm",
                                        ),
                                      if (openWeather.snow != null)
                                        _boxItemWidget(
                                          Icons.snowing,
                                          "Snow",
                                          "${openWeather.snow?.the1H ?? 0} mm",
                                        ),
                                    ])
                              ],
                            ),
                          ),
                        ],
                      ))
                else ...[
                  _introText(context),
                  _loadingWidget(),
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _boxItemWidget(IconData icon, String title, String value, [String? subtitle]) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey.shade300, size: 15),
              const CustomDivider(space: 5, direction: Axis.vertical,),
              Expanded(child: Text(title, style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey.shade300))),
            ],
          ),
          const CustomDivider(space: 5, direction: Axis.vertical,),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold))),
          if (subtitle != null) Text(subtitle, style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white))
        ],
      ),
    ).asGlass(clipBorderRadius: BorderRadius.circular(10));
  }

  Widget _weatherDetail(BuildContext context, WeatherResponse weatherResponse) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(children: [
        Text("${weatherResponse.main.temp.toStringAsFixed(0)}°", style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white)),
        const CustomDivider(space: 5, direction: Axis.vertical,),
        Text(weatherResponse.weather.first.main, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        const CustomDivider(space: 5, direction: Axis.vertical,),
        Text("Feels like : ${weatherResponse.main.feelsLike.toStringAsFixed(0)}°C", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white)),
      ]),
    );
  }

  Widget _introText(BuildContext context) {
    return Positioned(
      top: 30,
      left: 20,
      child: SafeArea(
        child: Text("Please wait\nBest things always took time...", style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontWeight: FontWeight.w100)),
      ),
    );
  }

  Widget _loadingWidget() {
    return const Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: CupertinoActivityIndicator(color: Colors.white),
        ),
      ),
    );
  }
}