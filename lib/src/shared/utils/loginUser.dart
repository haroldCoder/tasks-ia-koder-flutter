import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';

class LoginUser{
  dynamic login(String? email, String? cellphone, String username) async{
      final response = await Requests(baseUrl: dotenv.env['API_URL'].toString())
      .request(method: HttpMethod.post, endpoint: "users/login",
          body: {
            "email": email,
            "cellphone": cellphone,
            "username": username
          });

      return response;
  }
}