// ignore_for_file: non_constant_identifier_names

import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:http/http.dart' as http;

class Students {
  late String name;
  late String _class;
  late bool isPresent;
  bool isOD = false;
}

Future<http.Response> get_students_data(String class_) async {
  var parsedUrl = Uri.parse("${AppConfig.backendUrl}/attendance/");
  // http://127.0.0.1:8000/attendance/?lh=2-CSE-B

  try {
    var response = await http.post(
      parsedUrl,
      body: {
        'lh': class_,
      },
    );
    return response;
  } catch (e) {
    print(e);
    return http.Response(
      '{"message": "$e"}',
      401,
    );
  }
}
