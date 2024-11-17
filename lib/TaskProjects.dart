import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';
import 'ViewTask.dart';

class ProjectTask extends StatefulWidget {
  final String taskType;
  const ProjectTask({super.key, required this.taskType});

  @override
  State<ProjectTask> createState() => _ProjectTaskState();
}

class _ProjectTaskState extends State<ProjectTask> {
  dynamic filteredList = [];
  List<Map<dynamic, dynamic>> projectTask = [
    {
      'taskType': {'icon': '', 'color': '', 'typeName': 'Office Project'},
      'title': 'Grocery shopping app design',
      'description': 'Doing app design',
      'startDate': '12-11-2024',
      'endDate': '22-11-2024',
      'startTime': '12:24 AM',
      'endTime': '6:34 PM',
      'taskStatus': 'Completed',
    },
    {
      'taskType': {'icon': '', 'color': '', 'typeName': 'Personal Project'},
      'title': 'Uber Eats redesign challenge',
      'description': 'Doing app design',
      'startDate': '12-11-2024',
      'endDate': '22-11-2024',
      'startTime': '12:24 AM',
      'endTime': '6:34 PM',
      'taskStatus': 'Completed',
    },
    {
      'taskType': {'icon': '', 'color': '', 'typeName': 'Personal Project'},
      'title': 'Building App',
      'description': 'Building todo list app',
      'startDate': '12-11-2024',
      'endDate': '22-11-2024',
      'startTime': '12:24 AM',
      'endTime': '6:34 PM',
      'taskStatus': 'Completed',
    },
    {
      'taskType': {'icon': '', 'color': '', 'typeName': 'Work Assignment'},
      'title': 'Prepare presentation',
      'description': 'Design slides for the quarterly review meeting',
      'startDate': '15-11-2024',
      'endDate': '20-11-2024',
      'startTime': '10:00 AM',
      'endTime': '3:00 PM',
      'taskStatus': 'In Progress',
    },
    {
      'taskType': {'icon': '', 'color': '', 'typeName': 'Learning'},
      'title': 'Complete Flutter tutorial',
      'description': 'Follow the Udemy Flutter course',
      'startDate': '14-11-2024',
      'endDate': '24-11-2024',
      'startTime': '9:00 AM',
      'endTime': '5:00 PM',
      'taskStatus': 'Not Started',
    },
    {
      'taskType': {'icon': '', 'color': '', 'typeName': 'Fitness Goal'},
      'title': 'Daily Yoga Practice',
      'description': 'Complete a 30-minute yoga session every morning',
      'startDate': '10-11-2024',
      'endDate': '30-11-2024',
      'startTime': '7:00 AM',
      'endTime': '7:30 AM',
      'taskStatus': 'In Progress',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "${widget.taskType} Tasks",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
          SizedBox(
          height: 20,
        ),
            Container(
              padding: EdgeInsets.only(right: 10, left: 10),
        child:
            Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              width: MediaQuery.of(context).size.width ,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    filteredList = projectTask.where((item) {
                      return item['title']
                          .toLowerCase()
                          .contains(value.toLowerCase());
                    }).toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by name',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child:
            SingleChildScrollView(
              child: Column(
                children: projectTask.length != 0
                    ? List.generate(projectTask.length, (index) {
                  dynamic task = projectTask[index];
                  dynamic taskType = task['taskType'];
                  String icon = taskType['icon'];
                  String typeName = taskType['typeName'];
                  String color = taskType['color'];

                  if (icon.isEmpty && color.isEmpty) {
                    setState(() {
                      icon = iconAndColorDetermine(typeName)['icon'];
                      color = colorToHex(iconAndColorDetermine(typeName)['color']);
                    });
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewTaskScreen(
                          primaryColor: taskType['color'],
                          icon: taskType['icon'],
                          taskStatus: task['taskStatus'],
                          taskType: typeName,
                          taskName: task['title'],
                          description: task['description'],
                          startDate: task['startDate'],
                          endDate: task['endDate'],
                          startTime: task['startTime'],
                          endTime: task['endTime'],
                        ),
                      ));
                    },
                    child: taskCard(
                      icon,
                      task['title'],
                      typeName,
                      task['startTime'],
                      task['taskStatus'],
                      hexToColor(color),
                    ),
                  );
                })
                    : [
                  SizedBox(height: 50),
                  Text("No Task"),
                ],
              ),
            ),
            ),

          ],
        ));
  }

  String colorToHex(Color color) {
    return color.value.toRadixString(16).substring(2).toUpperCase();
  }

  taskCard(String icon, String taskName, String taskType, String taskTime,
      String taskStatus, Color primaryColor) {
    Color? statusColor = Color(0xff663BE3);
    if (taskStatus.toLowerCase().characters.characterAt(0).toString() == 'c') {
      statusColor = Color(0xff663BE3);
    } else if (taskStatus.toLowerCase().characters.characterAt(0).toString() ==
        'i') {
      statusColor = Color(0xffFF7D53);
    } else if (taskStatus.toLowerCase().characters.characterAt(0).toString() ==
        't') {
      statusColor = Color(0xff38A4FC);
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskType,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  taskName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Color(0xFFAB94FF),
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      taskTime,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFAB94FF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            // Right Section
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Task Type Icon
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: lightenColor(primaryColor, 0.70),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      width: 18,
                      height: 18,
                      icon,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Task Status
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: lightenColor(statusColor!, 0.80),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    taskStatus,
                    style: TextStyle(
                      fontSize: 14,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
