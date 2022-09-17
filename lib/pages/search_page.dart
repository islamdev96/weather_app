// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  SearchPage({super.key, this.updateUi});
  VoidCallback? updateUi;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/islam.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text('Search a City',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextField(
              style: const TextStyle(color: Colors.white, fontSize: 24),
              onChanged: (data) {
                cityName = data;
              },
              onSubmitted: (data) async {
                cityName = data;

                WeatherService service = WeatherService();

                WeatherModel? weather =
                    await service.getWeather(cityName: cityName!);

                Provider.of<WeatherProvider>(context, listen: false)
                    .weatherData = weather;
                Provider.of<WeatherProvider>(context, listen: false).cityName =
                    cityName;

                Navigator.pop(context);
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusColor: Colors.white,
                fillColor: Colors.grey[20],
                filled: true,
                alignLabelWithHint: true,
                counterStyle: const TextStyle(
                  color: Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    strokeAlign: StrokeAlign.inside,
                    style: BorderStyle.solid,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(35),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                label: const Text(
                  'search',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () async {
                    WeatherService service = WeatherService();

                    WeatherModel? weather =
                        await service.getWeather(cityName: cityName!);

                    Provider.of<WeatherProvider>(context, listen: false)
                        .weatherData = weather;
                    Provider.of<WeatherProvider>(context, listen: false)
                        .cityName = cityName;

                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
                hintText: 'Enter a city',
                hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
