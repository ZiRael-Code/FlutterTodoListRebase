import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/Login.dart';
import './AppMain.dart';
import 'LoginScreen.dart';
import 'MainNavigator.dart';
import 'Onboard.dart';
import 'SignUpScreen.dart';

void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home:
      MainActivity()));
}

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userStr = prefs.getString('user');

      if (userStr != null) {
        Map<String, dynamic> user = jsonDecode(userStr);

        bool logged = user['isLoggedIn'];
        int userId = user['id'];
        print("___+_+_+ is the status ${logged}");
        if (logged) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainNavigator(user: userStr),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }


      } else {
        // Navigate to Onboard screen if user data is null
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      }
    } catch (e) {
      // Handle unexpected errors gracefully
      print('Error checking login status: $e');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: [
            // Background Image
            Image.asset(
              "assets/todo.png",
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
            // Overlay Content
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Task Management & To-Do List",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Subtitle
                  Text(
                    "This productive tool is designed to help you better manage your tasks productively.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 180),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
