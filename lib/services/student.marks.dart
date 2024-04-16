import 'dart:convert';
import 'package:edumetricspro/services/students.dart';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> requestMarks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final rollNumber = prefs.getString("registerNumber");

  final token = getAuthToken();

  final response = await http.post(
    Uri.parse('${AppConfig.backendUrl}/results/students/marks/iit/me'),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "JWT $token",
    },
    body: {'rollNumber': rollNumber},
  );

  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    print(responseJson);
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
