import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';

class GetIdUser {
  late int Iduser;

  Future<int> buildRequest(user) async {
    var response = await Requests(baseUrl: dotenv.env["API_URL"].toString())
        .request(method: HttpMethod.get, endpoint: "users/user/${user}");

    Iduser = response["response"]["id"];

    print(response);

    return Iduser;
  }
}
