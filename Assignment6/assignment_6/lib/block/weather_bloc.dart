import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import './weather_events.dart';
import './weather_states.dart';
import '../weather_api.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherAPIService weatherApi;

  WeatherBloc({@required this.weatherApi}) : assert(weatherApi != null);

  @override
  WeatherState get initialState => WeatherInProgress();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    yield WeatherInProgress();

    final errorState = WeatherDone(
      desc: 'Error loading 🙁',
    );

    if (!(event is CitySelected)) {
      yield errorState;
      return;
    }

    try {
      final weather = await weatherApi.fetch((event as CitySelected).city);
      if (weather != null) {
        yield WeatherDone(
          temp: '${weather.temp}°C',
          range: '${weather.tempMin} - ${weather.tempMax}°C',
          desc: '${weather.desc}',
          loc: '${weather.city}\n${weather.country}',
        );
      } else {
        yield errorState;
      }
    } catch (e) {
      yield errorState;
    }
  }
}
