import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateUi() {
    setState(() {});
  }

  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

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
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchPage(
                      updateUi: updateUi,
                    );
                  }));
                },
                icon: const Icon(Icons.search),
              ),
            ],
            title: const Text('Weather App'),
          ),
          body: Provider.of<WeatherProvider>(context).weatherData == null
              ? Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: const [
                      Center(
                        child: Text(
                          'there is no weather 😔 start',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'searching now 🔍',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      weatherData!.getThemeColor(),
                      weatherData!.getThemeColor()[300]!,
                      weatherData!.getThemeColor()[100]!,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 3,
                      ),
                      Text(
                        Provider.of<WeatherProvider>(context).cityName!,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(weatherData!.getImage()),
                          Text(
                            weatherData!.temp.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                              Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        weatherData!.weatherStateName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(
                        flex: 5,
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
