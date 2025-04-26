import 'package:http/http.dart' as http;
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SubscriptionRequests {
  void createSubscription() async {
    final response =
        await Requests(baseUrl: dotenv.env['API_URL'].toString())
            .request(
                method: HttpMethod.post,
                endpoint: "v1/subscription/create-payment",
                body: {
          "success_url": "https://tasks-ia-koderx-congrats-page.vercel.app",
          "cancel_url": "https://www.google.com/"
        });
    final Uri uri = Uri.parse(response['response']['url']);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
