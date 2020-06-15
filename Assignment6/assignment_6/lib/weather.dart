import 'package:flutter/cupertino.dart';

class Weather {
  String temp;
  String tempMin;
  String tempMax;
  String desc;
  String city;
  String country;

  Weather.fromJson(Map<String, dynamic> json)
      : temp = (json['main']['temp']).toString(),
        tempMin = (json['main']['temp_min']).toString(),
        tempMax = (json['main']['temp_max']).toString(),
        desc = json['weather'][0]['description'],
        city = json['name'],
        country = json['sys']['country'];
}

class CityData extends ChangeNotifier {
  final cities = ['Karachi', 'Lahore', 'Islamabad', 'Rawalpindi'];
  String _selectedCity = 'Karachi';
  String get selectedCity => _selectedCity;

  CityData();

  void setSelectedCity(String newValue) {
    _selectedCity = newValue;
    notifyListeners();
  }
}
