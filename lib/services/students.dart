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
}

Future<dynamic> get_students_data(String class_) async {
  var parsedUrl = Uri.parse("${AppConfig.backendUrl}/attendance/");
  // http://127.0.0.1:8000/attendance/?lh=2-CSE-B

  try {
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

    return students;
  } catch (e) {
    print(e);
    return http.Response(
      '{"message": "$e"}',
      401,
    );
  }
}
