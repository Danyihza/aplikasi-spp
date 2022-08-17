import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/controllers/auth_controller.dart';
import 'package:flutter_app/app/networking/auth_api_service.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/controllers/controller.dart';

class LoginPage extends NyStatefulWidget {
  final AuthController authController = AuthController();
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends NyState<LoginPage> {
  @override
  @override
  init() async {
    super.init();
    _autoLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? role = prefs.getString('role');
    if (name != null && role != null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _onSignin() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await widget.authController.signin(
      username: usernameController.text,
      password: passwordController.text,
    );

    if (response['success'] == false) {
      showToast(
        style: ToastNotificationStyleType.DANGER,
        title: 'Error',
        description: "Invalid username or password",
      );
      usernameController.clear();
      passwordController.clear();
    } else {
      showToast(title: 'success', description: "Selamat Datang");
      prefs.setString('name', response['data']['nama']);
      prefs.setString('role', response['role']);
      if (response['role'] == 'siswa') {
        prefs.setInt('nisn', response['data']['nisn']);
      }
      if (response['role'] == 'siswa') {
        Navigator.pushReplacementNamed(context, '/home/siswa');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.grey[900]
          //color set to transperent or set your own color
          ),
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[900],
          padding: EdgeInsets.all(20),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Selamat Datang",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.comfortaa(
                    textStyle: TextStyle(
                      letterSpacing: 1,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                "Silahkan Masuk",
                textAlign: TextAlign.left,
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.grey[500],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18,
                      ),
                      hintText: 'Input your username',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.grey[500],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18,
                      ),
                      hintText: 'Input your password',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      _onSignin();
                    },
                    child: Text(
                      'Signin',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
