import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_ia_koderx/src/shared/utils/premiumUser.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key, required this.color_app});
  final Rx<Color> color_app;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool get verifyPremiumUser => ref.watch(premiumUserProvider);
  PremiumUserNotifier get verifyPremiumUserController => ref.read(premiumUserProvider.notifier);


  @override
  void initState() {
    super.initState();
    checkFirstTime();
    checkUserPremium();
  }

  Future<void> checkUserPremium() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final data_user = prefs.getString("data_user");

    if(data_user == null){
      verifyPremiumUserController.resetPremiumUser();
      return;
    }

    final Map<String, dynamic> userJson = jsonDecode(data_user);

    verifyPremiumUserController.verifyUser(userJson['email'].toString());
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
      backgroundColor: widget.color_app.value,
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
            "Tasks Koderx IA",
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 25,
            ),
          )
        ]),
      ),
    ));
  }
}
