import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/components/divider.dart';
import 'package:weatherapp/components/weather_info.dart';
import 'package:weatherapp/utils/extensions.dart';
import '../components/animated_background.dart';
import '../components/greeting_header.dart';
import '../components/loader.dart';
import '../providers/weather_provider.dart';
import '../resources/app_colors.dart';
import '../utils/utils.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, value, child) {
        var weatherData = value.weatherData;
        return Container(
          decoration:
          BoxDecoration(gradient: backgroundWeatherGradient()),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedBackground(weatherData?.weather.first.weatherType),
                if (weatherData != null)
                  SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const GreetingHeader(),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    weatherData.name,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                        fontSize: 30,
                                        color: dynamicTextColor(),
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 20, top: 20),
                              children: [
                                Column(children: [
                                  Container(
                                    // date
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 3),
                                    color: Colors.black,
                                    child: Text(formattedCurrentTime(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ).asGlass(
                                      clipBorderRadius: BorderRadius.circular(4)),
                                  const CustomDivider(
                                    space: 20,
                                    direction: Axis.vertical,
                                  ),
                                  Text(
                                      weatherData
                                          .weather.first.main, // mist/rain/sunny
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          color: dynamicTextColor(),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  const CustomDivider(
                                    space: 5,
                                    direction: Axis.vertical,
                                  ),
                                  Text(
                                      "${weatherData.main.temp.toStringAsFixed(0)}°", // weather
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                          color: dynamicTextColor(),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 150)),
                                  Text(
                                      "Real feel: ${weatherData.main.feelsLike.toStringAsFixed(0)}°C",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                        fontSize: 18,
                                        color: dynamicTextColor(),
                                      )),
                                ]),
                                const CustomDivider(
                                  space: 50,
                                  direction: Axis.vertical,
                                ),
                                GridView(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 0),
                                    children: [
                                      WeatherInfo(
                                        icon: Icons.wind_power,
                                        title:"Wind",
                                        value:"${weatherData.wind.speed.toStringAsFixed(1)} m/s",
                                      ),
                                      WeatherInfo(
                                        icon: Icons.water_drop,
                                        title: "Humidity",
                                        value: "${weatherData.main.humidity}%",
                                      ),
                                      WeatherInfo(
                                        icon: Icons.cloud,
                                        title: "Clouds",
                                        value: "${weatherData.clouds.all}%",
                                      ),

                                      // //Conditional rain and snow
                                      // if (weatherData.rain != null)
                                      //   WeatherInfo(
                                      //     Icons.water,
                                      //     "Rain",
                                      //     "${weatherData.rain?.the1H ?? 0} mm",
                                      //   ),
                                      // if (weatherData.snow != null)
                                      //   WeatherInfo(
                                      //     Icons.snowing,
                                      //     "Snow",
                                      //     "${weatherData.snow?.the1H ?? 0} mm",
                                      //   ),
                                    ]).asGlass(clipBorderRadius: BorderRadius.circular(10))
                              ],
                            ),
                          ),
                        ],
                      ))
                else ...[
                  const Loader(),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
