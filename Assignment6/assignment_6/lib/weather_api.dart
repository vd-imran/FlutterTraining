import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'weather.dart';

class WeatherAPIService {
  static const _APIKey = '4666afbc9bf79d1cd47e757e4121a334';

  const WeatherAPIService();

  Future<Weather> fetch(String city) async {
    final response = await http.get(
      'http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$_APIKey',
    );
    if (response.statusCode == 200) {
      return compute(_parse, response.body);
    } else {
      return null;
    }
  }

  static Weather _parse(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return Weather.fromJson(parsed);
  }
}
