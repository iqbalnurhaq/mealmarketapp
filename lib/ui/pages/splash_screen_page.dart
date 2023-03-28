import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mealmarketapp/theme/theme.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenColor,
      body: Center(
        child: Container(
          child: Text(
            'Meal Market',
            style: whiteTextStyle.copyWith(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
