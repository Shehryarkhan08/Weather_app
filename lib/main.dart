import 'package:flutter/material.dart';
import 'package:weather_app/home/home.dart';
import 'package:weather_app/screens/loadings/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      routes: {
        '/': (context) => const LoadingScreen(),
        "/home": (context) => const HomeScreen(),
        "/loading": (context) => const LoadingScreen()
      },
    );
  }
}
