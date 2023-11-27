import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: TextField(
            onSubmitted: (value) {
              final getWeatherCubit = BlocProvider.of<GetWeatherCubit>(context);
              getWeatherCubit.getWeather(cityName: value);
              Navigator.pop(context);
            },
            decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Enter City Name',
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}
