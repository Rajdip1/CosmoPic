import 'package:cosmopic/BottomNavigation.dart';
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
    // Add a delay of 3 seconds before navigating to the dashboard screen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bottomnavigation()), // Navigate to DashboardScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/1748495582049.png', height: 120),
            SizedBox(height: 20),
            // const CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            // ),
            SizedBox(height: 20),
            Text(
              "Welcome to COSMOPIC",
              style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
