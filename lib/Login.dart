import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/MainNavigator.dart';
import 'package:todo_list_flutter/SignUpScreen.dart';
import 'package:todo_list_flutter/utility/Validator.dart';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final Dio _dio = Dio();

  void _onLogin() async {
    if (passwordController.text.isEmpty || emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Disable button and show loading
    setState(() {
      isLoading = true;
    });

    final data = {
      "username": emailController.text,
      "password": passwordController.text,
    };

    try {
      Response response = await _dio.post(
        'http://192.168.1.14:8080/user/login', // Replace with your API endpoint
        // 'https://todolistapp-1-s2az.onrender.com/user/login', // Replace with your API endpoint
        data: data,
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {

        SharedPreferences prefs = await SharedPreferences.getInstance();
         String? userStr = prefs.getString('user');

        if (userStr == null) {
          Map<String, dynamic> user = {
            'id': response.data['id'],
            'username': response.data['username'],
            'email': response.data['email'],
            'isLoggedIn': response.data['loginStatus'],
          };

          String userJson = jsonEncode(user);
          await prefs.setString('user', userJson);
        }else {
          Map<String, dynamic> user = jsonDecode(userStr);
          user['isLoggedIn'] = response.data['loginStatus'];
          String userJson = jsonEncode(user);
          await prefs.setString('user', userJson);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainNavigator(user: userStr)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${response.data['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Server error: Please try again later")),
      );
    } finally {
      // Re-enable button and hide loading
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/signup.png',
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 280),
                      Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      // Email Input
                      inputField(headerType: "Username",),
                      SizedBox(height: 10),

                      // Password Input
                      inputField(headerType: "Password"),
                      SizedBox(height: 10),

                      // Forget Password and Signup
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Forget password?',
                            style: TextStyle(color: Colors.red),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
                              // Navigate to signup page
                            },
                            child: Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Login Button with Loading
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _onLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF9260F4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: isLoading
                              ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : AutoSizeText(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField({required String headerType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerType,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: headerType == "Username" ? emailController : passwordController,
          obscureText: headerType == "Password",
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
