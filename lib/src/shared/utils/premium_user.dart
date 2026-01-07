import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';

import 'Requests.dart';

final premiumUserProvider =
    StateNotifierProvider<PremiumUserNotifier, bool>((ref) {
  return PremiumUserNotifier();
});

class PremiumUserNotifier extends StateNotifier<bool> {
  late SharedPreferences prefs;

  PremiumUserNotifier() : super(false) {
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

    if (response?["response"]["hasPaid"]) {
      state = true;
      return true;
    }
    return false;
  }

  void resetPremiumUser() {
    state = false;
  }
}