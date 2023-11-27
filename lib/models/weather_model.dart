class WeatherModel {
  final String cityName;
  final DateTime lastUpdated;
  final String image;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String condition;

  const WeatherModel({
    required this.cityName,
    required this.lastUpdated,
    required this.image,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
  });

  factory WeatherModel.fromWeatherApiJson(json) {
    return WeatherModel(
      cityName: json['location']['name'],
      lastUpdated: DateTime.parse(json['current']['last_updated']),
      image: json['forecast']['forecastday'][0]['day']['condition']['icon'],
      temp: json['forecast']['forecastday'][0]['hour'][0]['temp_c'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      condition: json['forecast']['forecastday'][0]['day']['condition']['text'],
    );
  }

  factory WeatherModel.fromOpenWeatherJson(json) {
    return WeatherModel(
      cityName: json['name'],
      lastUpdated: DateTime.parse(
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000).toString()),
      image: json['weather'][0]['icon'],
      temp: json['main']['temp'],
      maxTemp: json['main']['temp_max'],
      minTemp: json['main']['temp_min'],
      condition: json['weather'][0]['description'],
    );
  }
}
