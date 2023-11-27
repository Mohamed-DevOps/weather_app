import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherApiService {
  final Dio dio;

  final String baseUrl = "https://api.weatherapi.com/v1";

  const WeatherApiService({required this.dio});

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      final apiKey = await getWeatherApiKey();
      final response = await dio
          .get("$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1");

      WeatherModel currentWeather =
          WeatherModel.fromWeatherApiJson(response.data);

      return currentWeather;
    } on DioException catch (e) {
      final String errMessage = e.response?.data['error']['message'] ??
          "Oops! there was an error, try later.";
      throw Exception(errMessage);
    } catch (e) {
      throw Exception("Oops! there was an error, try later.");
    }
  }
}

Future getWeatherApiKey() async {
  await dotenv.load(fileName: ".env");
  return dotenv.env["WEATHER_API_KEY"];
}
