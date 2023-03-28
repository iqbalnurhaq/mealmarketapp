import 'package:flutter/material.dart';
import 'package:mealmarketapp/model/restaurant.dart';
import 'package:mealmarketapp/ui/pages/detail_page.dart';
import 'package:mealmarketapp/ui/pages/home_page.dart';
import 'package:mealmarketapp/ui/pages/splash_screen_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreenPage(),
        '/home': (context) => HomePage(),
        '/detail': (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            )
      },
    );
  }
}
