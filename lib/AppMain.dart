// import 'dart:convert'; // For JSON handling
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // For shared preferences
// import './AppMain.dart'; // Import your AppMain widget
// import 'LoginScreen.dart'; // Import your LoginActivity equivalent in Flutter
// import 'SignUpScreen.dart'; // Import your SignUpActivity equivalent in Flutter
//
//
// void main(){
//   runApp(MainActivity());
// }
//
// class MainActivity extends StatefulWidget {
//   @override
//   _MainActivityState createState() => _MainActivityState();
// }
//
// class _MainActivityState extends State<MainActivity> {
//
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }
//
//   // Method to check login status
//   Future<void> _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userStr = prefs.getString('user');
//
//     if (userStr != null) {
//       Map<String, dynamic> user = jsonDecode(userStr); // Convert JSON to a Map
//       bool logged = user['isLoggedIn'] == 'true'; // Check login status
//
//       if (logged) {
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => AppMain(user: userStr)),
//         // );
//         print('___________\nlogged in');
//       } else {
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => LoginScreen()),
//         // );
//         print('___________\nnot logged in');
//       }
//     } else {
//       print('______________________\nthere is a problem with userStr');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           body: Container(
//               child: Stack(
//                 children: [
//                   Image.asset("assets/todo.png",
//                     fit: BoxFit.fill,
//                     height: double.infinity,
//                     width: double.infinity,
//                   ),
//
//                   Container(
//                     padding: EdgeInsets.all(15),
//                     alignment: Alignment.center,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.69,
//                           alignment: Alignment.center,
//                           child:
//                           Text(
//                             "Task Management & To-Do List",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//
//                         SizedBox(height: 10),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.65,
//                           alignment: Alignment.center,
//                           child:
//                           Text("This productive tool is designed to help you better manage your task product-wise convinient",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontSize: 17),
//
//                           ),
//                         ),
//
//                         SizedBox(height: 180,),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                               onPressed: () {
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFF5F33E1),
//                                 padding: EdgeInsets.symmetric(vertical: 15),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(12)),
//                                 ),
//                               ),
//                               child: Container(
//                                   padding: EdgeInsets.only(right: 10, left: 10),
//                                   child:
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Spacer(),
//                                       Text(
//                                         "Let's Start",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Container(
//                                         alignment: Alignment.centerRight,
//                                         child:   Icon(Icons.arrow_forward_outlined, color: Colors.white,),
//                                       )
//                                     ],))
//                           ),
//                         ),
//
//
//                         SizedBox(height: 50,)
//
//                       ],
//                     ),
//                   )
//
//                 ],))
//
//         // Center(
//         //   child: ElevatedButton(
//         //     onPressed: () => _getStarted(),
//         //     child: Text('Get Started'),
//         //   ),
//         // ),
//       ),
//     );
//   }
//
//   void _getStarted() {
//     // Navigator.push(
//     // context,
//     // MaterialPageRoute(builder: (context) => SignUpScreen()),
//     // );
//   }
// }
//
//
