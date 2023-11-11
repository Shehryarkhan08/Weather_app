import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/worker/worker.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  Future<void> startApp() async {
    Worker worker = Worker(location: 'Taxila');
    await worker.getData();
  }

  @override
  void initState() {
    super.initState();
    startApp();
  }

  @override
  Widget build(BuildContext context) {
    var cityName = [
      "Wah cantt",
      "Taxila",
      "Karachi",
      "Islamabad",
      "Rawalpindi",
      "Lahore",
      "Swat",
      "London",
      "Paris",
    ];
    final random = Random();
    var city = cityName[random.nextInt(cityName.length)];
    Map? infoRetrival = ModalRoute.of(context)?.settings.arguments as Map?;
    String tempp = infoRetrival?['temp_value'];
    String icon = infoRetrival?['icon_value'];

    String getCity = infoRetrival?['city_value'];
    // String getCity = infoRetrival != null ? infoRetrival['city_value'] : '';

    String humidity = infoRetrival?['humi_value'];

    String airSpeed = infoRetrival?['airspeed_value'];
    String desc = infoRetrival?['desc_value'];
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900,
                    Colors.orange.shade100
                  ], // Your gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // stops: [0.1, 0.9],
              colors: [Colors.blue.shade800, Colors.orange.shade100])),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ('/loading'),
                            arguments: {"searchText": searchController.text});
                      },
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 7, 0),
                          child: const Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                    ),
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          fillColor: Colors.black12),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                                "https://openweathermap.org/img/wn/$icon@2x.png"),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(desc,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Text("in $getCity",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            WeatherIcons.thermometer,
                            size: 30,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tempp,
                                style: const TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '°C',
                                style: TextStyle(fontSize: 40),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                WeatherIcons.day_cloudy_windy,
                                size: 30,
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.035),
                          Text(
                            airSpeed,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const Text('km/h', style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                WeatherIcons.humidity,
                                size: 30,
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.035),
                          Text(
                            humidity,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const Text('Percent', style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
