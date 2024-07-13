import 'dart:ui';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/my_data.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/main.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/widgets/color_gradient.dart';
import 'package:weather_app/widgets/image_widget.dart';
import 'package:weather_app/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getGreeting() {
    TimeOfDay currentTime = TimeOfDay.now();

    if (currentTime.period == DayPeriod.am) {
      return 'Good Morning';
    } else if (currentTime.hour < 12) {
      return 'Good Afternoon';
    } else if (currentTime.hour < 18) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    WeatherFactory wf =
        WeatherFactory(MyData.API_KEY, language: Language.ENGLISH);

    Future<Weather> getCurrentWeather() async {
      Position position = await determinePosition();
      return await wf.currentWeatherByLocation(
          position.latitude, position.longitude);
    }

    return FutureBuilder<Weather>(
      future: getCurrentWeather(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Stack(
            children: [
              ColorGradient(),
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.black,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    const ColorGradient(),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍  ${snap.data!.areaName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            getGreeting(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          getWeatherIcon(snap.data!.weatherConditionCode!),
                          const SizedBox(
                            height: 4,
                          ),
                          Center(
                            child: Text(
                              '${snap.data!.temperature!.celsius!.round()}°C',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              snap.data!.weatherMain!.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd •')
                                  .add_jm()
                                  .format(snap.data!.date!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/11.png',
                                    scale: 8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sunrise',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(snap.data!.sunrise!),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/12.png',
                                    scale: 8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sunset',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(snap.data!.sunset!),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ImageWidget(
                                    'assets/13.png',
                                    8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        Colors.white,
                                        'Temp Max',
                                        FontWeight.w300,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      TextWidget(
                                        Colors.white,
                                        "${snap.data!.tempMax!.celsius!.round()} °C",
                                        FontWeight.w300,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ImageWidget(
                                    'assets/14.png',
                                    8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        Colors.white,
                                        'Temp Min',
                                        FontWeight.w300,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      TextWidget(
                                        Colors.white,
                                        "${snap.data!.tempMin!.celsius!.floor()} °C",
                                        FontWeight.w300,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
