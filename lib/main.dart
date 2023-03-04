import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/cities_provider.dart';
import 'package:weatherapp/providers/navigation_provider.dart';
import 'package:weatherapp/providers/weather_provider.dart';
import 'package:weatherapp/resources/app_theme.dart';
import 'package:weatherapp/screens/navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => CitiesProvider())
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      home: const NavigationScreen(),
    );
  }
}
