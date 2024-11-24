import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate a delay, then navigate to the home screen.
    Timer(const Duration(seconds: 15), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/icons/res.gif', // Ensure the correct image path
          fit: BoxFit.cover, // Make the image cover the entire screenc
          width: double.infinity, // Set width to fill screen
          height: double.infinity, // Set height to fill screen
        ),
      ),
    );
  }
}
