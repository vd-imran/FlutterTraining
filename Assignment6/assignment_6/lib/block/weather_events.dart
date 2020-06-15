import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class CitySelected extends WeatherEvent {
  final String city;

  const CitySelected({@required this.city});

  @override
  List<Object> get props => [city];
}
