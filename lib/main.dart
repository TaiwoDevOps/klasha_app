import 'package:flutter/material.dart';
import 'package:klasha_app/features/splash/splash_screen.dart';
import 'package:klasha_app/providers.dart';
import 'package:klasha_app/di/di.dart' as locator;

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init service locator => 1
  await locator.initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ingredient App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
