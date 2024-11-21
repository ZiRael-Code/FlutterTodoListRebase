import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/AddTask.dart';
import 'package:todo_list_flutter/TodaysTask.dart';
import 'Profile.dart';
import 'Dashboard.dart';
import 'Notifications.dart';

class MainNavigator extends StatefulWidget {
  final String? user;
  MainNavigator({required this.user});
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final Dio _dio = Dio();
  late Map<String, dynamic> user = new Map<String, dynamic>();
  late dynamic fetchedData;
  bool isLoading = true;

  bool isTaskStarted(DateTime startDate, DateTime startTime, DateTime endDate,
      DateTime endTime) {
    DateTime now = DateTime.now();

    // Check if the start date is today or has passed
    if (startDate.isBefore(now) || startDate.isAtSameMomentAs(now)) {
      // Check if the start time is now or has passed
      if (startTime.isBefore(now) || startTime.isAtSameMomentAs(now)) {
        // Check if the start time is not equal to or has not passed the end time
        if (startTime.isBefore(endTime)) {
          // Check if the start date is not equal to or has not passed the end date
          if (startDate.isBefore(endDate)) {
            return true; // All conditions met
          }
        }
      }
    }

    return false; // One or more conditions failed
  }

  bool isTaskCompleted(DateTime startDate, DateTime endDate, DateTime startTime,
      DateTime endTime) {
    DateTime now = DateTime.now();

    // Check if the start date equals the end date
    if (startDate == endDate) {
      // Check if the start time equals the end time
      if (startTime == endTime) {
        // Check if the start time, end time, and current time (now) are equal
        if (startTime == now) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }


  void _fetchData() async {
    user = jsonDecode(widget.user.toString());
    int id = user["id"];
    print("{}{}_)(_{} the id i got $id");
    try {
      Response response = await _dio.get(
        'http://192.168.1.14:8080/user/getMobileNavPackage/$id',
        // Endpoint with path parameter
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        // print("weeee got it and it working yea hoooooooooo"+response.data);
        setState(() {
          fetchedData = response.data;
          isLoading = false;
        });
      }
    } catch (e) {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // Show a popup if there's no network
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("No Network Connection"),
            content: Text("Please check your internet connection."),
            actions: [
              TextButton(
                onPressed: () {
                  // Retry logic
                  Navigator.of(context).pop(); // Close the dialog
                  _fetchData(); // Recheck the network
                },
                child: Text("Retry"),
              ),
              TextButton(
                onPressed: () {
                  // Exit the app
                  Navigator.of(context).pop();
                  Future.delayed(Duration(milliseconds: 200), () {
                    // Close the app (if allowed)
                    exit(0);
                  });
                },
                child: Text("Exit"),
              ),
            ],
          ),
        );
      } else {
        _fetchData();
      }
    } finally {
      var connectivityResult = await Connectivity().checkConnectivity();
    }
  }

  int _selectedIndex = 0;



  void _onItemTapped(int index, BuildContext context) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTaskScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading){
      return MaterialApp(
          home: Scaffold(body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
      )
      );
    }else{

      final List<Widget> _screens = [
        Dashboard(dashboard: fetchedData['dashboard']),
        TodayTask(),
        Container(), //
        Notifications(),
        Profile(),
      ];
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (index) => _onItemTapped(index, context),
            selectedItemColor: Color(0xff9260F4),
            unselectedItemColor: Colors.grey,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _selectedIndex == 0
                      ? 'assets/selected_bottomNav_icon/home.svg'
                      : 'assets/unselected_bottomNav_icon/home.svg',
                  width: 32,
                  height: 32,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _selectedIndex == 1
                      ? 'assets/selected_bottomNav_icon/todaytask.svg'
                      : 'assets/unselected_bottomNav_icon/todaytask.svg',
                  width: 32,
                  height: 32,
                ),
                label: 'Today Task',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/addtask.svg',
                  width: 52,
                  height: 52,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _selectedIndex == 3
                      ? 'assets/selected_bottomNav_icon/notification.svg'
                      : 'assets/unselected_bottomNav_icon/notification.svg',
                  width: 32,
                  height: 32,
                ),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _selectedIndex == 4
                      ? 'assets/selected_bottomNav_icon/profile.svg'
                      : 'assets/unselected_bottomNav_icon/profile.svg',
                  width: 39,
                  height: 39,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
  }
}
