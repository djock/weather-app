import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if(_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  static NavigationProvider read(BuildContext context) => context.read();
}