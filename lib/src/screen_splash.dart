import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Agrega un constructor con key opcional

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    await Future.delayed(const Duration(seconds: 3));

    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }
    if(!mounted) return;
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
            spacing: 20,
            children: [
          Image.asset(
            'lib/assets/lion.jpeg',
            width: 150,
          ),
          Text(
            "Tesks Koderx IA",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.blue,
              fontSize: 25,

            ),
          )
        ]),
      ),
    ));
  }
}
