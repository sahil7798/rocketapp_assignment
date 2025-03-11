import 'package:flutter/material.dart';
import 'package:rocketapp_assignment/provider/rocket_data_provider.dart';
import 'package:rocketapp_assignment/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:rocketapp_assignment/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RocketController()),
      ],
      child: MaterialApp(
        title: 'Rocket App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
