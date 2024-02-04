import 'dart:convert';

import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;

Future<Map<String, List<List<String>>>> get_staff_timetable(
    String name_) async {
  try {
    var parsedUrl =
        Uri.parse("${AppConfig.backendUrl}/timetable/full/staff/$name_");
    // "http://localhost:8000/timetable/student/$class_"

    var response = await http.get(parsedUrl);
    var rawData = json.decode(response.body);

    if (rawData["status"] == 200) {
      try {
        // return Map<String, List<List<String>>>.from((rawData["data"]));
        var convertedData = _convertData(rawData["data"]);
        print(convertedData.toString());
        if (convertedData.toString() == "{}") {
          return {
            "message": [
              ["Unable to process data"]
            ]
          };
        }
        return convertedData;
      } catch (e) {
        print("Error in services.stafftimetable: $e");
      }
    }
    return {
      "message": [
        ["Unable to get data"]
      ]
    };
  } catch (e) {
    print("Exception in services.student: $e");
    return {
      "message": [
        ["Unable to process data"]
      ]
    };
  }
}

Map<String, List<List<String>>> _convertData(dynamic data) {
  if (data is Map<String, dynamic>) {
    Map<String, List<List<String>>> convertedData = {};

    data.forEach((key, value) {
      if (value is List) {
        List<List<String>> innerList = [];

        for (var item in value) {
          if (item is List && item.length == 3) {
            innerList.add(List<String>.from(item));
          }
        }

        convertedData[key] = innerList;
      }
    });

    return convertedData;
  }

  return {};
}
