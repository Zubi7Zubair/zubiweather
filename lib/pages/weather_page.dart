import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zubiweather/bloc/weather_bloc_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // if its morning show morning if its afternoon show afternoon if its evening show evening if its night show night
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    if (hour < 20) {
      return 'Evening';
    }
    return 'Night';
  }

  Widget getWeatherAnimation(int code){
    switch(code){
      case >=200 && < 300 :
        return Lottie.asset('assets/lottie/thunder.json');
      case >=300 && < 400 :
        return Lottie.asset('assets/lottie/rain.json');
      case >=500 && < 600 :
        return Lottie.asset('assets/lottie/rain.json');
      case >=600 && < 700 :
        return Lottie.asset('assets/lottie/snow.json');
      case >=700 && < 800 :
        return Lottie.asset('assets/lottie/mist.json');
      case == 800 :
        return Lottie.asset('assets/lottie/sunney.json');
      case >800 && <= 804 :
        return Lottie.asset('assets/lottie/cloud.json');
      default:
        return Lottie.asset('assets/lottie/sunny.json');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26.0,horizontal: 15),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(500),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(500),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  color: Colors.transparent,
                )),
            SingleChildScrollView(
              child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📍 ${state.weather.areaName}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                         Text(getGreeting(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        Center(
                            child: getWeatherAnimation(state.weather.weatherConditionCode!)),
                         Center(
                          child: Text(

                            '${state.weather.temperature!.celsius!.round()}°C',

                            style: TextStyle(

                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 55),
                            textAlign: TextAlign.center,
                          ),
                        ),
                         Center(
                          child: Text(
                            state.weather.weatherMain!.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 25),
                          ),
                        ),
                         Center(
                          child: Text(
                            DateFormat('EEEE d .').add_jm().format(state.weather.date!),

                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/icon/sunrise.png',
                                    width: 50, height: 50),
                                const SizedBox(
                                  width: 5,
                                ),
                                 Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sunrise',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      DateFormat().add_jm().format(state.weather.sunrise!),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('assets/icon/sunset.png',
                                    width: 50, height: 50),
                                const SizedBox(
                                  width: 5,
                                ),
                                 Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sunset',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                  DateFormat().add_jm().format(state.weather.sunset!),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/icon/temprature max.png',
                                    width: 50, height: 50),
                                const SizedBox(
                                  width: 5,
                                ),
                                 Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Temp Max',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "${state.weather.tempMax!.celsius!.round()} °C",

                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('assets/icon/temprature min.png',
                                    width: 50, height: 50),
                                const SizedBox(
                                  width: 5,
                                ),
                                 Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Temp Min',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "${state.weather.tempMin!.celsius!.round()} °C",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
