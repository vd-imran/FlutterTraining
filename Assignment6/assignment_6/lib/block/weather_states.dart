import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherDone extends WeatherState {
  final String temp;
  final String range;
  final String desc;
  final String loc;

  const WeatherDone({
    this.temp = '',
    this.range = '',
    this.desc = '',
    this.loc = '',
  });

  @override
  List<Object> get props => [temp, range, desc, loc];
}

class WeatherInProgress extends WeatherState {}
