import 'package:flutter/material.dart';
import 'package:islam_app/screens/onboarding_screens/onboarding_1.dart';
import 'package:islam_app/widgets/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramadan App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffd6a75f)),
        useMaterial3: true,
      ),
      home: OnBoarding(),
    );
  }
}

