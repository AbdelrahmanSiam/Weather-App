import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Cubits/get_current_weather/get_weather_cubits.dart';
import 'package:weather_app/Cubits/get_current_weather/get_weather_states.dart';
import 'package:weather_app/Views/Screens/home_view_screen.dart';
import 'package:weather_app/Views/Screens/no_weathe_screen.dart';
import 'package:weather_app/Views/Screens/weather_screen.dart';
import 'package:weather_app/Views/Screens/city_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) => BlocBuilder<GetWeatherCubit, WeatherStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: getWeatherColor(
                  BlocProvider.of<GetWeatherCubit>(context).weatherModel?.state,
                ),
              ),
              home: HomeViewScreen(),
              );
          },
        ),
      ),
    );
  }
}

MaterialColor getWeatherColor(String? day) {
  if (day == null) {
    return Colors.blue;
  }
  switch (day.toLowerCase()) {
    case 'sunny':
    case 'clear':
      return Colors.orange; // sunny => warm color
    case 'partly cloudy':
    case 'cloudy':
    case 'overcast':
      return Colors.blueGrey; // cloudy => neutral
    case 'mist':
    case 'fog':
    case 'freezing fog':
      return Colors.grey; // fog/mist => grey
    case 'patchy rain possible':
    case 'light rain':
    case 'moderate rain at times':
    case 'moderate rain':
    case 'heavy rain at times':
    case 'heavy rain':
    case 'moderate or heavy rain with thunder':
      return Colors.blue; // rainy => blue
    case 'patchy snow possible':
    case 'light snow':
    case 'moderate snow':
    case 'heavy snow':
    case 'patchy light snow with thunder':
    case 'moderate or heavy snow with thunder':
      return Colors.lightBlue; // snowy => light blue
    case 'patchy sleet possible':
    case 'light sleet':
    case 'moderate or heavy sleet':
      return Colors.indigo; // sleet => indigo
    case 'patchy freezing drizzle possible':
    case 'freezing drizzle':
    case 'heavy freezing drizzle':
    case 'light freezing rain':
    case 'moderate or heavy freezing rain':
      return Colors.cyan; // freezing rain/drizzle
    case 'thundery outbreaks possible':
      return Colors.deepPurple; // thunder => deep purple
    default:
      return Colors.teal; // fallback
  }
}
