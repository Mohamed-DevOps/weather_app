import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';

class OpenWeatherService {
  final Dio dio;

  final String baseUrl = "https://api.openweathermap.org/data/2.5";

  const OpenWeatherService({required this.dio});

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      final apiKey = await getOpenWeatherApiKey();
      final response = await dio
          .get("$baseUrl/weather?q=$cityName&appid=$apiKey&units=metric");

      WeatherModel currentWeather =
          WeatherModel.fromOpenWeatherJson(response.data);

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

Future getOpenWeatherApiKey() async {
  await dotenv.load(fileName: ".env");
  return dotenv.env["OPEN_WEATHER_API_KEY"];
}
