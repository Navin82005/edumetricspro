import 'dart:convert';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getAttendancePercentage(String student, String lh) async {
  var parsedUrl =
      Uri.parse("${AppConfig.backendUrl}/attendance/percentage/$lh/$student");
  // print(parsed_url);
  var response = await http.get(
    parsedUrl,
  );

  var data = json.decode(response.body);
  print(data);

  return data["data"];
}
