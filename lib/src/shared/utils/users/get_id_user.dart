import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';

class GetIdUser {
  late int Iduser;

  Future<int> buildRequest(String user) async {
    if(user == ""){
      return 0;
    }

    var response = await Requests(baseUrl: dotenv.env["API_URL"].toString())
        .request(method: HttpMethod.get, endpoint: "v1/users/users/$user");

    Iduser = response["response"]["id"];

    return Iduser;
  }
}
