import 'dart:async';

import 'package:todo_list_flutter/utility/Url.dart';
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
  final int index;
  final dynamic fetchedData;
  MainNavigator({required this.user, required this.index, required this.fetchedData});
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final Dio _dio = Dio();
  late Map<String, dynamic> user = new Map<String, dynamic>();
  late dynamic fetchedData = widget.fetchedData;
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


  void assignFetch(dynamic data){
    setState(() {
      fetchedData = data;
    });
  }


  void _fetchData() async {
    user = jsonDecode(widget.user.toString());
    if(fetchedData == null){
    // int id = user["id"];
    int id = 1;

    try {
      // Add a 10-second timeout to the API call
      Response response = await _dio.get(
        '$baseUrl$mobilePack$id',
        options: Options(contentType: Headers.jsonContentType),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException("Request timed out after 10 seconds"),
      );

      if (response.statusCode == 200) {
        setState(() {
          fetchedData = response.data;
          isLoading = false;
        });
      }
    } on TimeoutException catch (_) {
      // Handle timeout (show Retry/Exit dialog)
      _showTimeoutDialog();
    } catch (e) {
      // Handle other errors (network, etc.)
      await _handleNetworkError();
    }
    }
  }

// Helper: Show Retry/Exit Dialog on Timeout
  void _showTimeoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Request Timeout"),
        content: Text("The server took too long to respond."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _fetchData(); // Retry
            },
            child: Text("Retry"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              exit(0); // Exit app
            },
            child: Text("Exit"),
          ),
        ],
      ),
    );
  }

  Future<void> _handleNetworkError() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("No Network Connection"),
          content: Text("Please check your internet connection."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _fetchData(); // Retry
              },
              child: Text("Retry"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                exit(0); // Exit app
              },
              child: Text("Exit"),
            ),
          ],
        ),
      );
    } else {
      _fetchData(); // Retry if the error wasn't a network issue
    }
  }

  late int _selectedIndex = widget.index;



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
        Dashboard(onItemTapped: _onItemTapped, dashboard: fetchedData['dashboard'], assignFetchData: assignFetch,),
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
