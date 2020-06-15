import 'package:assignment6/weather_api.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import './block/weather_bloc.dart';
import './block/weather_events.dart';
import './block/weather_states.dart';
import 'weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Assignment 6';
  final weatherAPIService = WeatherAPIService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: BlocProvider(
        create: (context) => WeatherBloc(
          weatherApi: weatherAPIService,
        ),
        child: ChangeNotifierProvider(
          create: (_) => CityData(),
          child: HomePage(
            appTitle: appTitle,
          ),
        ),
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
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refresh,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CityDropDown(),
            SizedBox(height: 20),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) => (state is WeatherDone)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildWeatherDetails(context, state),
                    )
                  : CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildWeatherDetails(
    BuildContext context,
    WeatherDone weatherData,
  ) =>
      [
        Text(
          weatherData.temp,
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        Text(
          weatherData.range,
          style: TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          weatherData.desc,
          style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
        Text(
          weatherData.loc,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ];

  void _refresh() {
    BlocProvider.of<WeatherBloc>(context).add(
      CitySelected(
        city: Provider.of<CityData>(
          context,
          listen: false,
        ).selectedCity,
      ),
    );
  }
}

class CityDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CityData>(context);

    return DropdownButton<String>(
      value: provider.selectedCity,
      elevation: 16,
      style: TextStyle(color: Colors.blueAccent),
      underline: Container(
        height: 2,
        color: Colors.blueAccent,
      ),
      onChanged: (String newValue) {
        provider.setSelectedCity(newValue);
        BlocProvider.of<WeatherBloc>(context).add(CitySelected(city: newValue));
      },
      items: provider.cities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
