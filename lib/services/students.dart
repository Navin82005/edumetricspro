import 'dart:convert';

import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Students {
  late String name;
  late String _class;
  late String rollNumber;
  late bool isPresent;
  late bool isOD = false;

  Students(this.name, this._class, this.rollNumber, this.isPresent, this.isOD);

  void display() {
    print("$name $rollNumber $_class $isPresent ");
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'class': _class,
      'rollNumber': rollNumber,
      'isPresent': isPresent,
      'isOD': isOD
    };
  }
}

Future<String?> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access');
  return token;
}

Future<dynamic> get_students_data(String class_, String time_) async {
  try {
    var token = await getAuthToken();
    if (token == null) {
      return {"message": "Token not found"};
    }

    var parsedUrl = Uri.parse("${AppConfig.backendUrl}/attendance/$time_");
    var response = await http.post(
      parsedUrl,
      headers: {
        'Authorization': 'JWT $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'lh': class_,
      },
    );

    var rawData = json.decode(response.body)['body'];
    var period_ = rawData['period'];

    List<Students> students =
        List<Students>.from(rawData['data'].map((studentData) {
      return Students(
        studentData['name'],
        class_,
        studentData['rollNumber'],
        studentData['isPresent'],
        studentData['isOD'],
      );
    }));

    return {'students': students, 'period': period_};
  } catch (e) {
    print(e);
    return {"message": "Unable to get data"};
  }
}

Future<void> sendStudentData(List<Students> students, String class_,
    String period_, String classTime) async {
  try {
    var token = await getAuthToken();
    if (token == null) {
      print("Token not found");
      return;
    }

    var parsedUrl = Uri.parse(
      '${AppConfig.backendUrl}/attendance/mark/$class_/$classTime/$period_/',
    );

    List<Map<String, dynamic>> jsonList =
        students.map((student) => student.toJson()).toList();

    var jsonData = jsonEncode(jsonList);

    var response = await http.post(
      parsedUrl,
      headers: {
        'Authorization': 'JWT $token',
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );
    print(response.body);
  } catch (e) {
    print(e);
  }
}

Future<dynamic> get_time_table(String class_) async {
  try {
    var token = await getAuthToken();
    if (token == null) {
      return {"message": "Token not found"};
    }

    var parsedUrl =
        Uri.parse("${AppConfig.backendUrl}/timetable/student/$class_");

    var response = await http.post(
      parsedUrl,
      headers: {
        'Authorization': 'JWT $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    var rawData = json.decode(response.body);

    if (rawData["status"] == 200) {
      return {"data": rawData["data"]};
    }
    return {"message": "Unable to get data"};
  } catch (e) {
    print("Exception in services.student: $e");
    return {"message": "Unable to get data"};
  }
}
