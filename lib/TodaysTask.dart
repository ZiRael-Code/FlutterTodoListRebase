import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_flutter/Dashboard.dart'; // Import for date formatting

void main() {
  runApp(TodayTask());
}

class TodayTask extends StatefulWidget {
  @override
  _TodayTaskState createState() => _TodayTaskState();
}

class _TodayTaskState extends State<TodayTask> {

  // Map<String, String> taskStatusMap = ;

  int selectedIndex = 0;
  int statusSelectedIndex = 0;
  List<String> taskStatusTab = ["All", "To do", "In Progress", "Completed"];
  List<Map<dynamic, dynamic>> allTask = [
    {
      'taskType': 'All Tasks',
      'title': 'To Do',
      'in_progress': 'In Progress',
      'completed': 'Completed',
    }

  ];
  List<String> dateClicked = [];
  String taskStatus = "";
  List<DateTime> generateDateList() {
  DateTime today = DateTime.now();




  DateTime startDate = DateTime(today.year, today.month, 1);
  List<DateTime> dateList = [];
      while (startDate.isBefore(today) || startDate.isAtSameMomentAs(today)) {
      dateList.add(startDate);
      startDate = startDate.add(Duration(days: 1)); // Move to the next day
    }
    return dateList;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dateList = generateDateList(); // Generate the list of dates

    return MaterialApp(
      home: Scaffold(
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
            "Today's Task",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Notification icon
                Icon(
                  Icons.notifications,
                  size: 28,
                  color: Colors.black,
                ),
                // Orange dot indicating notification
                Positioned(
                  top: 0,
                  right: 3,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xff5f33e1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [

              // Horizontal ListView of dates
              Container(
                padding: EdgeInsets.only(top: 20), // Add padding at the top
                height: 103,
                child:SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                  children: List.generate(dateList.length, (index) {
                    bool isSelected = selectedIndex == index;
                    Color backgroundColor = Colors.white;
                    Color textColor = Colors.black;
                    if (isSelected){
                      backgroundColor = Color(0xff5F33E1);
                      textColor = Colors.white;
                    }else{
                      backgroundColor = Colors.white;
                      textColor = Colors.black;
                    }

                    DateTime currentDate = dateList[index];
                    String day = DateFormat('EEE').format(currentDate); // Day (e.g., Sun)
                    String month = DateFormat('MMM').format(currentDate); // Month (e.g., May)
                    String date = DateFormat('d').format(currentDate);

                    return  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index; // Update the selected index
                          dateClicked = [day, month, date];
                          allTask = filterTask([day, month, date], taskStatus);
                        });
                      },
                      child: Container(
                        width: 76,
                        height: 92,
                        margin: EdgeInsets.only(right: 1, left: 12),
                        decoration: BoxDecoration(
                          color: backgroundColor ,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              month,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              date,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              day,
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                ),
                ),
              SizedBox(height: 30),
        Container(
          padding: EdgeInsets.only(left: 20),
          child:
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row( // Removed Expanded
              children: List.generate(taskStatusTab.length, (index) {
                bool isSelected = statusSelectedIndex == index;
                Color backgroundColor = isSelected ? Color(0xff5F33E1) : Color(0xffEDE8FF);
                Color textColor = isSelected ? Colors.white : Color(0xff5F33E1);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      statusSelectedIndex = index;
                      taskStatus = taskStatusTab[index];
                      allTask = filterTask(dateClicked, taskStatus);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      taskStatusTab[index],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
      )
      ),
              SizedBox(height: 30),
                 Container(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: allTask.isNotEmpty ?
                      List.generate(allTask.length, (index) {
                        dynamic task = allTask[index];
                         return taskCard(
                             'assets/office.png',
                             task['title'],
                             task['taskType'],
                             '10:00 AM',
                             'Inprogress',
                         Color(0xFFEC407A)
                         );



                        // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(12),
                          //     color: Colors.white,
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Row(children: [
                          //         Text(task['taskType'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          //       ],),
                          //       SizedBox(height: 15,),
                          //       Text(task['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          //       SizedBox(height: 15,),
                          //       Row(children: [],)
                          //     ],
                          //   ),
                          // );
                    })
                          :
                          [
                            SizedBox(height: 50,),
                            Text("No Task")
                          ]
                    ),
                  )
                )
            ],
          ),
        ),
      ),
    );
  }

 taskCard(
   String icon,
    String taskName,
   String taskType,
    String taskTime,
   String taskStatus,
     Color primaryColor
  ) {
    Color? statusColor;
    if (taskStatus.toLowerCase().characters.characterAt(0).toString() == 'c' ){
      statusColor = Color(0xff663BE3);
    }else if (taskStatus.toLowerCase().characters.characterAt(0).toString() == 'i' ){
      statusColor = Color(0xffFF7D53);
    }else if (taskStatus.toLowerCase().characters.characterAt(0).toString() == 't' ){
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
                  child:
                Container(
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

  // Refactored date widget to accept parameters
  Widget dateWidget({
    required String day,
    required String month,
    required String date,
    required int selectedIndex,
    required int index,
  }) {
    bool isSelected = selectedIndex == index;
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black;
    if (isSelected){
      backgroundColor = Color(0xff5F33E1);
      textColor = Colors.white;
    }else{
      backgroundColor = Colors.white;
      textColor = Colors.black;
    }

    return  GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index; // Update the selected index
          });
    },
      child: Container(
      width: 76,
      height: 92,
      margin: EdgeInsets.only(right: 12, left: 12),
      decoration: BoxDecoration(
        color: backgroundColor ,
        borderRadius: BorderRadius.circular(15),
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              month,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              day,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dateColourChanger() {
    print('Date color changed');
  }

  List<Map<dynamic, dynamic>> filterTask(List<String> date, String taskStatus) {
    return [ {
      'all': '',
      'todo': '',
      'in_progress': '',
      'completed': '',
    }];
  }
}




