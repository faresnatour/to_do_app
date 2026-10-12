import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/screens/log_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Lottie.asset(
            "assets/images/smiley_logo_lottie.json",
            width: double.infinity,
            height: 250,
            repeat: false,
          ),
        ],
      ),
    );
  }

  void nextScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogInScreen()),
      );
    });
  }
}
