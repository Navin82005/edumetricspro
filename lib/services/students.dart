// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;

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

Future<dynamic> get_students_data(String class_) async {
  try {
    var parsedUrl = Uri.parse("${AppConfig.backendUrl}/attendance/");
    // http://127.0.0.1:8000/attendance/?lh=2-CSE-B
    var response = await http.post(
      parsedUrl,
      body: {
        'lh': class_,
      },
    );

    // var data1 = json.decode(response.body);
    // var decoded = json.decode(data1['body']);

    // // List<Students> students = List<Students>();
    // print(decoded);

    var data1 = json.decode(response.body)['body'];
    print(data1[0]['name']);

    List<Students> students = List<Students>.from(
      data1.map(
        (studentData) {
          return Students(
            studentData['name'],
            class_,
            studentData['rollNumber'],
            studentData['isPresent'],
            studentData['isOD'],
          );
        },
      ),
    );

    for (var stud in students) {
      stud.display();
    }

    return {'students': students};
  } catch (e) {
    print(e);
    return {"message": "Unable to get data"};
  }
}

Future<void> sendStudentData(List<Students> students, String class_) async {
  var parsedUrl = Uri.parse('${AppConfig.backendUrl}/attendance/mark/$class_/');

  // String jsonData = jsonEncode(students);
  // print(jsonData);

  List<Map<String, dynamic>> jsonList =
      students.map((student) => student.toJson()).toList();

  var jsonData = jsonEncode(jsonList);

  print(jsonData);

  try {
    var response = await http.post(
      parsedUrl,
      headers: {
        'content-type': 'application/json',
      },
      body: jsonData,
    );
    print(response.body);
  } catch (e) {
    print(e);
  }
}
