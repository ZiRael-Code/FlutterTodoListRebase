import 'dart:convert'; // For JSON handling
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For shared preferences
import './AppMain.dart'; // Import your AppMain widget
import 'LoginScreen.dart'; // Import your LoginActivity equivalent in Flutter
import 'MainNavigator.dart';
import 'Onboard.dart';
import 'SignUpScreen.dart'; // Import your SignUpActivity equivalent in Flutter


void main(){
  runApp(MainActivity());
}

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userStr = prefs.getString('user');

    if (userStr != null) {
      Map<String, dynamic> user = jsonDecode(userStr);
      bool logged = user['isLoggedIn'] == 'true';
      int userId = user['id'];

      if (userId != 0) {
        if (logged) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>
                MainNavigator(userString: userStr,)),
          );
          print('___________\nlogged in');
        }else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
          print('___________\nnot logged in');
        }
      }else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onboardscreen()),
        );
      }

    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboardscreen()),
      );
      print('___________\nnot logged in');
    }
  }


@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
        body: Container(
            child: Stack(
              children: [
                Image.asset("assets/todo.png",
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),

                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(
                        width: MediaQuery.of(context).size.width * 0.69,
                        alignment: Alignment.center,
                        child:
                        Text(
                          "Task Management & To-Do List",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        alignment: Alignment.center,
                        child:
                        Text("This productive tool is designed to help you better manage your task product-wise convinient",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),

                        ),
                      ),

                      SizedBox(height: 180,),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Color(0xFF5F33E1),
                      //       padding: EdgeInsets.symmetric(vertical: 15),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.all(Radius.circular(12)),
                      //       ),
                      //     ),
                      //     child: Container(
                      //       padding: EdgeInsets.only(right: 10, left: 10),
                      //       child:
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Spacer(),
                      //     Text(
                      //       "Let's Start",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18,
                      //       ),
                      //     ),
                      //         Spacer(),
                      //         Container(
                      //         alignment: Alignment.centerRight,
                      //          child:   Icon(Icons.arrow_forward_outlined, color: Colors.white,),
                      //         )
                      //     ],))
                      //   ),
                      // ),


                      SizedBox(height: 50,)

                    ],
                  ),
                )

              ],))
    ),
  );
}
}


