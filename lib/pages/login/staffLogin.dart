// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:edumetricspro/components/FontStyles.dart';
import 'package:edumetricspro/services/auth.dart';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:edumetricspro/themes/LoginPageColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffLogin extends StatefulWidget {
  const StaffLogin({super.key});

  @override
  State<StaffLogin> createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
  String staffEmail = '';
  String staffPassword = '';
  bool passwordVisibility = true;
  bool isUserValid = true;
  bool isUserPasswordValid = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // <a href="https://lovepik.com/images/backgrounds-the-advertisement.html">The Advertisement  by Lovepik.com</a>
          image: AssetImage(
            'assets/login/background/background.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: LoginPageColors.backgroundColor,
            ),
          ),
          title: Text(
            AppConfig.appName,
            style: AppFonts.fontPoppins,
          ),
          actions: <Widget>[
            Image.asset(
              'assets/app icons/transparent-1024.png',
            ),
          ],
        ),
        body: Column(
          children: [
            //
            SizedBox(height: 20),
            //
            RichText(
              text: TextSpan(
                text: "Welcome ",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Lecture",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
            SizedBox(height: 20.0),
            Text(
              "Login",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 20.0),

            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Name",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        //
                        hintText: "name@siet.ac.in",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        //
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        //
                      ),
                      onChanged: (value) {
                        staffEmail = value.toString();
                        print(staffEmail);
                      },
                    ),
                    Text(
                      !isUserValid ? "Please provide valid username" : "",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      "Password",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "mypassword",
                        //
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        //
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        //
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                passwordVisibility = !passwordVisibility;
                              },
                            );
                          },
                          icon: Icon(passwordVisibility
                              ? Icons.visibility_off
                              : Icons.visibility),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onChanged: (value) {
                        staffPassword = value.toString();
                        print(staffPassword);
                      },
                      obscureText: passwordVisibility,
                    ),
                    if (!isUserPasswordValid)
                      Text(
                        "Please provide valid password",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 25.0,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                          ),
                          onPressed: () {
                            if (!staffEmail.contains('@')) {
                              setState(
                                () {
                                  isUserValid = false;
                                },
                              );
                            } else {
                              setState(() {
                                isUserValid = true;
                              });
                            }
                            if (staffPassword.length <= 8) {
                              setState(() {
                                isUserPasswordValid = false;
                              });
                            } else {
                              setState(() {
                                isUserPasswordValid = true;
                              });
                            }

                            if (staffEmail.contains('@') &&
                                staffPassword.length >= 8) {
                              print(
                                '$staffEmail $staffPassword',
                              );
                              setState(() {
                                isUserPasswordValid = isUserValid = true;
                              });
                              AuthLogin.login(
                                  'staff', staffEmail, staffPassword);
                            }
                          },

                          //
                          // Footer
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 8.0,
                            ),
                            child: Text(
                              "Submit",
                              style: GoogleFonts.poppins(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //
            // Footer
            Expanded(child: SizedBox()),

            Container(
              color: Theme.of(context).colorScheme.background,
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forgot Password, contact the admin",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
