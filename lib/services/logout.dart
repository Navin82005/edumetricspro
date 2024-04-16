import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:flutter/material.dart';

class Logout {
  static Future<void> logout(context) async {
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
