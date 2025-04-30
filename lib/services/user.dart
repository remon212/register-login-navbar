import 'dart:convert';
import 'package:movie/models/response_data_map.dart';
import 'package:movie/models/user_login.dart';
import 'package:movie/services/url.dart' as url;
import 'package:http/http.dart' as http;

class UserService {
  Future loginUser(data) async {
    var uri = Uri.parse(url.BaseUrl + "/login");
    var register = await http.post(uri, body: data);

    if (register.statusCode == 200) {
      var data = json.decode(register.body);
      if (data["status"] == true) {
        UserLogin userLogin = UserLogin(
          status: data["status"],
          token: data["authorisation"]["token"],
          message: data["message"],
          id: data["data"]["id"],
          nama_user: data["data"]["name"],
          email: data["data"]["email"],
          role: data["data"]["role"],
        );
        await userLogin.prefs();
        ResponseDataMap response = ResponseDataMap(
          status: true,
          message: "Sukses login user",
          data: data,
        );
        return response;
      } else {
        return ResponseDataMap(
          status: false,
          message: 'Email dan password salah',
        );
      }
    } else {
      return ResponseDataMap(
        status: false,
        message: "gagal login user dengan code error ${register.statusCode}",
      );
    }
  }

  registerUser(Map<String, String?> data) {}
}
