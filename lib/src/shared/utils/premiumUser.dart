import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';

import 'Requests.dart';

class PremiumUser extends GetxController {
  late SharedPreferences prefs;
  Rx<bool> isPremium = false.obs;

  PremiumUser() {
    initializeSharedPrefences();
  }

  void initializeSharedPrefences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> verifyUser(String email) async {
    final response = await Requests(baseUrl: dotenv.env['API_URL'].toString())
        .request(
            method: HttpMethod.get,
            endpoint: "v1/subscription/verify-payment/$email");

    if(response?["response"]["hasPaid"]){
      isPremium.value = true;
      return true;
    }
    return false;
  }

  void ResetPremiumUser(){
    isPremium.value = false;
  }
}
