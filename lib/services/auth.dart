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
    Box userData = await Hive.openBox('userData');

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

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 401) {
        return {'status': 401};
      } else if (response.statusCode == 200) {
        var decodedBody = json.decode(response.body);
        loginBox.put('type', mode);
        loginBox.put('login', true);
        print("Login in Auth: ${loginBox.get('login')}");
        loginBox.put('refresh', decodedBody['refresh']);

        var userBody = decodedBody['userData'];
        userData.put('name', userBody['name']);
        userData.put('username', userBody['username']);

        if (mode == 'staff') userData.put('isAdvisor', userBody['isAdvisor']);

        decodedBody['status'] = 200;
        return decodedBody;
      }
      return {'status': 204};
    } catch (error) {
      // print('Error: ${error.toString()}');
      return {'status': 204};
    }
  }
}
