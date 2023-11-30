import 'dart:convert';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthLogin {
  static Future<Map> login(
      String mode, String username, String password) async {
    // final url = Uri.parse('${AppConfig.backendUrl}/auth/$mode/login/');

    Box loginBox = await Hive.openBox('Login');

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
      if (response.statusCode == 401) {
        return {'status': 401};
      } else if (response.statusCode == 200) {
        loginBox.put('type', mode);
        loginBox.put('login', true);
        loginBox.put('refresh', json.decode(response.body)['refresh']);
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
