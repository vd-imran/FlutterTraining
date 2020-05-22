import 'package:assignment4/weather_api.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Assignment 3';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: HomePage(
        appTitle: appTitle,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String appTitle;

  HomePage({this.appTitle});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String temp = '';
  String range = '';
  String desc = '';
  String loc = '';

  List<String> cities = ['Karachi', 'Lahore', 'Islamabad', 'Rawalpindi'];
  String selectedCity = 'Karachi';

  bool isLoading = false;

  void _updateData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final weather = await WeatherAPIService.fetch(selectedCity);
      if (weather != null) {
        setState(() {
          temp = '${weather.temp}°C';
          range = '${weather.tempMin} - ${weather.tempMax}°C';
          desc = '${weather.desc}';
          loc = '${weather.city}\n${weather.country}';
        });
      } else {
        print('weather null');
        _showError();
      }
    } catch (e) {
      print(e);
      _showError();
    }
    setState(() {
      isLoading = false;
    });
  }

  void _showError() {
    temp = '';
    range = '';
    desc = 'Error loading 🙁';
    loc = '';
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _updateData();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isLoading ? CircularProgressIndicator() : Container(),
              DropdownButton<String>(
                value: selectedCity,
                elevation: 16,
                style: TextStyle(color: Colors.blueAccent),
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    selectedCity = newValue;
                  });
                  _updateData();
                },
                items: cities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Text(
                temp,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Text(
                range,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                desc,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                loc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
      ),
    );
  }
}
