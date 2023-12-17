import 'dart:convert';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;

Future<dynamic> get_staff_timetable(String staff) async {
  var parsed_url = Uri.parse("${AppConfig.backendUrl}/timetable/staff/$staff");
  // print(parsed_url);
  var response = await http.post(
    parsed_url,
  );

  var data = json.decode(response.body);

  for (var i in data["timetable"]) {
    print(i);
  }

  // print("Response $data");
  return data;
}
