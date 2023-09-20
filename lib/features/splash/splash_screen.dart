import 'package:flutter/material.dart';
import 'package:klasha_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:klasha_app/utils/extensions/duration_ext.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(3.seconds, () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return const DashboardScreen();
      }), (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.pink,
          image: DecorationImage(
            image: AssetImage('assets/klasha.png'),
            fit: BoxFit.contain,
            scale: 2,
          ),
        ),
      ),
    );
  }
}
