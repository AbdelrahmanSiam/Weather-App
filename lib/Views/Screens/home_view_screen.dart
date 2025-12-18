import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Cubits/get_current_weather/get_weather_cubits.dart';
import 'package:weather_app/Cubits/get_current_weather/get_weather_states.dart';
import 'package:weather_app/Views/Screens/city_search_screen.dart';
import 'package:weather_app/Views/Screens/no_weathe_screen.dart';
import 'package:weather_app/Views/Screens/weather_screen.dart';
import 'package:weather_app/main.dart';

class HomeViewScreen extends StatelessWidget {
  const HomeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: getWeatherColor(
          BlocProvider.of<GetWeatherCubit>(context).weatherModel?.state,
        ),
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Weather App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            if (BlocProvider.of<GetWeatherCubit>(context).weatherModel != null)
              Text(
                BlocProvider.of<GetWeatherCubit>(context).weatherModel!.city,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                ),
              ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              tooltip: 'Search City',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CitySearchScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      body: BlocBuilder<GetWeatherCubit, WeatherStates>(
        builder: (context, state) {
          if (state is WeatherInitialState) {
            return const NoWeatherScreen();
          } else if (state is WeatherLoadedState) {
            return WeatherScreen(
              weather: state.weatherModel,
            );
          } else {
            return const Center(child: Text("Oops,there are an error"));
          }
        },
      ),
      // body: weatherModel == null ? NoWeatherScreen() : WeatherScreen(), // while using weatherModels as global variable
    );
  }
}
