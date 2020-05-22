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
