import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/pages/home_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWeatherCubit, WeatherState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(
            //   seedColor: Colors.blue,
            // ),
            primarySwatch: getThemeColor(
                BlocProvider.of<GetWeatherCubit>(context)
                    .weatherModel
                    ?.condition),
            // appBarTheme: const AppBarTheme(
            //   foregroundColor: Colors.white,
            //   backgroundColor: Colors.blue,
            // ),
            // useMaterial3: true,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) return Colors.blue;

  switch (condition) {
    case "Sunny":
    case "Clear":
      return Colors.orange;
    case "Partly cloudy":
      return Colors.lightBlue;
    case "Cloudy":
    case "Patchy rain possible":
    case "Overcast":
    case "Mist":
      return Colors.indigo;
    default:
      return Colors.blueGrey;
  }
}
