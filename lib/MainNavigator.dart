import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/AddTask.dart';
import 'package:todo_list_flutter/TodaysTask.dart';
import 'Profile.dart';
import 'Dashboard.dart';
import 'Notifications.dart';

class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {

  late Map<String, dynamic> user;
  @override
  void initState() {
    // TODO: implement initState
    _checkLoginStatus();
    super.initState();
  }

  Future<void> _checkLoginStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userStr = prefs.getString('user');

      if (userStr != null) {
        user = jsonDecode(userStr);
      }
    }
    catch (error) {
      print('Error checking login status: $error');
    }
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Dashboard(),
    TodayTask(),
    Container(), //
    Notifications(),
    Profile(),
  ];

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