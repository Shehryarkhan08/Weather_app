import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/worker/worker.dart';

// loading_screen.dart

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String city = "Taxila";
  String? temp;
  String? humi;
  String? airSpe;
  String? desc;
  String? main;
  String? icon;
  Future<void> startApp(String city) async {
    Worker worker = Worker(location: city);
    await worker.getData();
    temp = worker.temperature;
    humi = worker.humidity;
    airSpe = worker.airSpeed;
    desc = worker.description;
    main = worker.main;
    icon = worker.icon;

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "humi_value": humi,
        "airspeed_value": airSpe,
        "desc_value": desc,
        "main_value": main,
        "icon_value": icon,
        "city_value": city
      });
    });

    // ignore: use_build_context_synchronously
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;

    if (search?.isNotEmpty ?? false) {
      city = search?['searchText'];
    }
    startApp(city);
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xFF197DFF),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              Image.asset(
                'assets/images/logos.png',
                height: height * 0.4,
                width: width * 1,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                'Weather App',
                style: GoogleFonts.pacifico(fontSize: 38),
                // style: TextStyle(
                //     color: Color.fromARGB(255, 2, 24, 42),
                //     fontSize: 23,
                //     fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              const SpinKitFadingCube(
                color: Colors.white,
                size: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
