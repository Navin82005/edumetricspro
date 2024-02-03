import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Logout {
  static Future<void> logout(context) async {
    late Box loginDataBox, userDataBox;

    loginDataBox = await Hive.openBox('login');
    userDataBox = await Hive.openBox('userData');

    loginDataBox.put('type', null);
    loginDataBox.put('login', false);
    loginDataBox.put('refresh', null);

    userDataBox.put('name', null);
    userDataBox.put('username', null);
    userDataBox.put('isAdvisor', false);

    Navigator.pushAndRemoveUntil(
      context,
      SlideLiftRoute(child: const MainLogin()),
      (route) => false,
    );
  }

  static void popStack(context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      SlideLiftRoute(child: widget),
      (route) => false,
    );
  }
}
