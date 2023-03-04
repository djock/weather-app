import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/components/notification_bar.dart';
import 'package:weatherapp/providers/cities_provider.dart';

import '../components/loader.dart';
import '../providers/navigation_provider.dart';
import '../providers/weather_provider.dart';
import '../resources/app_colors.dart';

class CitiesListScreen extends StatefulWidget {
  const CitiesListScreen({super.key});

  @override
  CitiesListScreenState createState() => CitiesListScreenState();
}

class CitiesListScreenState extends State<CitiesListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CitiesProvider>(context, listen: false).loadCities();
  }

  String selectedCity = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<CitiesProvider>(
      builder: (context, value, child) {
        var citiesList = value.cities;
        return Container(
          decoration:
              BoxDecoration(gradient: backgroundWeatherTheme().backround),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Cities',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    if (value.cities.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: citiesList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  color: selectedCity == citiesList[index].name
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.transparent,
                                  child: ListTile(
                                    title: Text(citiesList[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                    trailing: Checkbox(
                                      activeColor: Colors.black,
                                      value: selectedCity ==
                                          citiesList[index].name,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCity =
                                                citiesList[index].name;
                                          } else {
                                            selectedCity = '';
                                          }
                                        });
                                      },
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (selectedCity ==
                                            citiesList[index].name) {
                                          selectedCity = '';
                                        } else {
                                          selectedCity = citiesList[index].name;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.white,
                                  thickness: 0.5,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    else
                      const Loader(),
                    if (value.cities.isNotEmpty)
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedCity.isEmpty) {
                              NotificationBar.build(context, 'Error',
                                  'Please select a city', Colors.red);
                            } else {
                              var city = citiesList.firstWhere(
                                  (element) => element.name == selectedCity);
                              var weatherProvider =
                                  Provider.of<WeatherProvider>(context,
                                      listen: false);
                              weatherProvider.currentLocation = [
                                city.latitude,
                                city.longitude
                              ];
                              weatherProvider.loadWeather();

                              Provider.of<NavigationProvider>(context,
                                      listen: false)
                                  .changeIndex(0);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: Text('Get weather',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
