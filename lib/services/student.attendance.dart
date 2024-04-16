import 'dart:convert';
import 'package:edumetricspro/services/services.actions.dart';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getAttendancePercentage(String? rollnumber, String? sem) async {
  print(rollnumber);
  print(sem);
  var parsedUrl = Uri.parse(
      "${AppConfig.backendUrl}/attendance/percentage/$sem/$rollnumber");

  final accessToken = await service.getAccessToken();

  var response = await http.get(
    parsedUrl,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'JWT $accessToken',
      'Accept': 'application/json',
    },
  );

  var data = json.decode(response.body);
  print("data: $data");

  return data["data"];
}
