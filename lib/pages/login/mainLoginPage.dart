// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:edumetricspro/components/FontStyles.dart';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:edumetricspro/themes/LoginPageColors.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class MainLogin extends StatelessWidget {
  const MainLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LoginPageColors.primaryColor,
        title: Text(
          AppConfig.appName,
          style: AppFonts.fontPoppins,
        ),
        actions: <Widget>[
          // Text("Hello"),
          Image.asset(
            'assets/app icons/transparent-1024.png',
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                // <a href="https://lovepik.com/images/backgrounds-the-advertisement.html">The Advertisement  by Lovepik.com</a>
                image: AssetImage(
                  'assets/login/background/background.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Welcome to EduMatricsPro",
                    style: TextStyle(
                      color: LoginPageColors.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "Continue to app after login",
                    style: TextStyle(
                      color: LoginPageColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //
                  //
                  Expanded(
                    child: Image.asset("assets/login/users/presentation.png"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print("Student Login");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LoginPageColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "STUDENT",
                      style: TextStyle(
                        color: LoginPageColors.backgroundColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //
                  //
                  Expanded(
                    child: Image.asset(
                      "assets/login/users/audience.png",
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print("Lecturer Login");
                      Navigator.pushNamed(context, 'staffLogin');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LoginPageColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "LECTURER",
                      style: TextStyle(
                        color: LoginPageColors.backgroundColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //
                  //
                  Expanded(
                    child: Image.asset("assets/login/users/support.png"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print("Admin Login");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LoginPageColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "ADMIN",
                      style: TextStyle(
                        color: LoginPageColors.backgroundColor,
                      ),
                    ),
                  ),
                  //
                  //
                  Expanded(
                    child: Container(
                      height: 120.0,
                    ),
                  ),
                  Container(
                    color: LoginPageColors.blackColor,
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account, contact the admin",
                          style: TextStyle(
                            color: LoginPageColors.backgroundColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
