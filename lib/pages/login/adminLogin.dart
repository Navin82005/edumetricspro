// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:edumetricspro/components/FontStyles.dart';
import 'package:edumetricspro/pages/home/adminHome.dart';
import 'package:edumetricspro/pages/login/mainLoginPage.dart';
import 'package:edumetricspro/services/auth.dart';
import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:edumetricspro/themes/LoginPageColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String adminEmail = '';
  String adminPassword = '';
  bool passwordVisibility = true;
  bool isUserValid = true;
  bool isUserPasswordValid = true;
  bool loading = false;
  bool error = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                        text: "Admin",
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
                            hintText: "admin@siet.ac.in",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            //
                            prefixIcon: Icon(
                              Icons.person,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            //
                          ),
                          onChanged: (value) {
                            adminEmail = value.toString();
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
                            hintText: "adminpassword",
                            //
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
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
                            adminPassword = value.toString();
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
                              onPressed: () async {
                                if (!adminEmail.contains('@')) {
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
                                if (adminPassword.length <= 8) {
                                  setState(() {
                                    isUserPasswordValid = false;
                                  });
                                } else {
                                  setState(() {
                                    isUserPasswordValid = true;
                                  });
                                }

                                if (adminEmail.contains('@') &&
                                    adminPassword.length >= 8) {
                                  print(
                                    '$adminEmail $adminPassword',
                                  );
                                  setState(() {
                                    isUserPasswordValid = isUserValid = true;
                                  });

                                  setState(() {
                                    loading = true;
                                  });

                                  Map response = await AuthLogin.login(
                                      'admin', adminEmail, adminPassword);
                                  print(response);
                                  if (response['status'] == 204) {
                                    setState(() {
                                      error = true;
                                    });
                                  } else if (response['status'] == 401) {
                                    setState(() {
                                      error = false;
                                      isUserPasswordValid = isUserValid = false;
                                    });
                                  }
                                  if (response['status'] == 200) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdminHome(),
                                      ),
                                    );
                                    setState(() {
                                      error = false;
                                      isUserPasswordValid = isUserValid = true;
                                    });
                                  }

                                  setState(() {
                                    loading = false;
                                  });
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
                        if (error)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Center(
                              child: Text(
                                "Unable to connect to server",
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                            ),
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
        ),
        if (loading)
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Lottie.asset('assets/loaders/blueCircleLoader.json'),
            ),
          ),
      ],
    );
  }
}
