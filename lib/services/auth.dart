import 'dart:convert';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;

class AuthLogin {
  static Future<bool> login(
      String mode, String username, String password) async {
    final url = Uri.parse('${AppConfig.backendUrl}/auth/$mode/login/');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (error) {
      print('Error: $error');
    }

    bool status = false;

    return status;
  }
}
