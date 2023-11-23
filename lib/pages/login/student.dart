// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(235, 94, 40, 1),
        title: Text(
          "EduMatrixPro",
          style: TextStyle(
            color: Color.fromRGBO(255, 252, 242, 1),
          ),
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
                image: AssetImage(
                  'assets/login/background/background-01.png',
                ),
                fit: BoxFit.cover,
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
                      color: Color.fromRGBO(255, 252, 242, 1),
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Continue to app after login",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 252, 242, 1),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  //
                  //
                  Container(
                    child: Image.asset("assets/login/users/presentation.png"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print("Student Login");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(235, 94, 40, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "STUDENT",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 252, 242, 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //
                  //
                  Container(
                    child: Image.asset(
                      "assets/login/users/audience.png",
                      width: 128.0,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print("Lecturer Login");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(235, 94, 40, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "LECTURER",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 252, 242, 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //
                  //
                  Container(
                    child: Image.asset("assets/login/users/support.png"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print("Admin Login");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(235, 94, 40, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "ADMIN",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 252, 242, 1),
                      ),
                    ),
                  ),
                  //
                  //
                  Expanded(child: Container()),
                  Container(
                    color: Color.fromRGBO(37, 36, 34, 1),
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account contact the admin",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 252, 242, 1),
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
