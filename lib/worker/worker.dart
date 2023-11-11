import 'dart:convert';

import 'package:http/http.dart' as http;

class Worker {
  String? location;
  String? temperature;
  String? humidity;
  String? airSpeed;
  String? description;
  String? main;
  String? icon;

  Worker({required this.location});

  Future<void> getData() async {
    try {
      var response = await http.get(Uri.parse('Your open weather Api'));
      Map data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // getting temperature and humidity

        Map tempDate = data['main'];
        double getTemperaturekelvin = tempDate['temp'];
        double getTemperatureCelsius = getTemperaturekelvin - 273.15;
        String getHumidity = tempDate['humidity'].toString();

        // getting description

        List weatherData = data['weather'];
        Map weatherMainData = weatherData[0];
        String getDesc = weatherMainData['description'];
        String getMainDesc = weatherMainData['main'];

        // air speed

        Map wind = data['wind'];
        double getWindSpeed = wind['speed'] * 3.6;

        // assign val
        temperature = getTemperatureCelsius.toStringAsFixed(2);
        humidity = getHumidity;
        airSpeed = getWindSpeed.toStringAsFixed(2);
        description = getDesc;
        main = getMainDesc;
        icon = weatherMainData['icon'].toString();
      }
    } catch (e) {
      temperature = 'error occured';
      humidity = 'error occured';
      airSpeed = 'error occured';
      description = 'error occured';
      main = 'error occured';
      icon = 'error occured';
    }
  }
}
