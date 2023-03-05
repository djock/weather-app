import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/resources/app_colors.dart';
import 'package:weatherapp/screens/cities_list_screen.dart';
import 'package:weatherapp/screens/weather_screen.dart';

import '../providers/navigation_provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> _widgetOptions = <Widget>[
    const WeatherScreen(),
    const CitiesListScreen(),
  ];

  void _onItemTapped(int index) {
    Provider.of<NavigationProvider>(context, listen: false).changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, value, child) {
        var selectedIndex = value.currentIndex;

        return Scaffold(
          extendBody: true,
          body: _widgetOptions.elementAt(selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.cyan.withOpacity(0.1),
            elevation: 0,
            selectedItemColor: dynamicTextColor(),
            unselectedItemColor: dynamicTextColor().withOpacity(0.7),
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.sunny),
                label: 'Weather',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 24,
                  child: Icon(Icons.location_city),
                ),
                label: 'Cities',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
