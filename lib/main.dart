import 'package:display_detective/screens/color_score.dart';
import 'package:display_detective/screens/contrast_check.dart';
import 'package:display_detective/screens/home.dart';
import 'package:display_detective/screens/refresh_meter.dart';
import 'package:display_detective/screens/resolution_count.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Home.route,
      routes: {
        Home.route: (context) => const Home(),
        ColorScope.route: (context) => const ColorScope(),
        ResolutionCount.route: (context) => const ResolutionCount(),
        RefreshMeter.route: (context) => const RefreshMeter(),
        ContrastCheck.route: (context) => const ContrastCheck(),
      },
    );
  }
}
