class Weather {
  int temp;
  int tempMin;
  int tempMax;
  String desc;
  String city;
  String country;

  Weather.fromJson(Map<String, dynamic> json)
      : temp = json['main']['temp'],
        tempMin = json['main']['temp_min'],
        tempMax = json['main']['temp_max'],
        desc = json['weather'][0]['description'],
        city = json['name'],
        country = json['sys']['country'];
}
