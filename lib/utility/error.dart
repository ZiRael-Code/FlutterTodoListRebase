import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
//
// void _showTimeoutDialog() {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => AlertDialog(
//       title: Text("Request Timeout"),
//       content: Text("The server took too long to respond."),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//             _fetchData(); // Retry
//           },
//           child: Text("Retry"),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//             exit(0); // Exit app
//           },
//           child: Text("Exit"),
//         ),
//       ],
//     ),
//   );
// }
//
// Future<void> _handleNetworkError(BuildContext context) async {
//   var connectivityResult = await Connectivity().checkConnectivity();
//   if (connectivityResult == ConnectivityResult.none) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: Text("No Network Connection"),
//         content: Text("Please check your internet connection."),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _fetchData(); // Retry
//             },
//             child: Text("Retry"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               exit(0); // Exit app
//             },
//             child: Text("Exit"),
//           ),
//         ],
//       ),
//     );
//   } else {
//     _fetchData(); // Retry if the error wasn't a network issue
//   }
// }