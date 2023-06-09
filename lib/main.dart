import 'package:flutter/material.dart';
import 'package:mealmarketapp/data/api/api_service.dart';
import 'package:mealmarketapp/provider/restaurant_provider.dart';
import 'package:mealmarketapp/ui/pages/detail_page.dart';
import 'package:mealmarketapp/ui/pages/home_page.dart';
import 'package:mealmarketapp/ui/pages/search_page.dart';
import 'package:mealmarketapp/ui/pages/splash_screen_page.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreenPage(),
          '/home': (context) => HomePage(),
          '/detail': (context) => DetailPage(
                idRes: ModalRoute.of(context)?.settings.arguments as String,
              ),
          '/search': (context) => SearchPage(),
        },
      ),
    );
  }
}
