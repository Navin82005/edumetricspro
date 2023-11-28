import 'dart:convert';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;

class AuthLogin {
  static Future<Map> login(
      String mode, String username, String password) async {
    // final url = Uri.parse('${AppConfig.backendUrl}/auth/$mode/login/');

    try {
      final response = await http.post(
        Uri.parse('${AppConfig.backendUrl}/auth/$mode/login/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
      );

      // final response = await http.post(
      //   Uri.parse('https://www.youtube.com/watch?v=CeyuxntJTu8'),
      // );
      //

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      // return Map(response.body);
      // print(response);
      if (response.statusCode == 401) {
        return {'status': 401};
      } else if (response.statusCode == 200) {
        var parsedBody = json.decode(response.body);
        parsedBody['status'] = 200;
        return parsedBody;
      }
      return {'status': 204};
    } catch (error) {
      // print('Error: ${error.toString()}');
      return {'status': 204};
    }
  }
}
