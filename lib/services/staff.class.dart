import 'dart:convert';

import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> getStaffClassStudents(String lh) async {
  try {
    var parsedUrl =
        Uri.parse("${AppConfig.backendUrl}/timetable/staff/get-class/$lh");

    var response = await http.get(parsedUrl);
    var rawData = json.decode(response.body);

    if (rawData["status"] == 200) {
      try {
        // Assuming rawData["data"] is a List<dynamic> of maps
        return List<Map<String, dynamic>>.from(rawData["data"]);
      } catch (e) {
        print("Error in services.getStaffClassStudents: $e");
      }
    }
    return [
      {
        "message": ["Unable to get data"]
      }
    ];
  } catch (e) {
    print("Exception in services.student: $e");
    return [
      {"message": "Unable to process data"}
    ];
  }
}

Future<List<Map<String, dynamic>>> getStaffClassStudent(String rollNo) async {
  try {
    var parsedUrl = Uri.parse(
        "${AppConfig.backendUrl}/timetable/staff/get-student/$rollNo");

    var response = await http.get(parsedUrl);
    var rawData = json.decode(response.body);

    if (rawData["status"] == 200) {
      try {
        // Assuming rawData["data"] is a List<dynamic> of maps
        return List<Map<String, dynamic>>.from(rawData["data"]);
      } catch (e) {
        print("Error in services.getStaffClassStudents: $e");
      }
    }
    return [
      {
        "message": ["Unable to get data"]
      }
    ];
  } catch (e) {
    print("Exception in services.student: $e");
    return [
      {"message": "Unable to process data"}
    ];
  }
}
