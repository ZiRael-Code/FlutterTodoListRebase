import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list_flutter/MainNavigator.dart';
import 'package:todo_list_flutter/TaskProjects.dart';

import 'ViewTask.dart';
import 'package:todo_list_flutter/utility/Url.dart';



class  Dashboard extends StatefulWidget{
  final dynamic dashboard;
  final void Function(int index, BuildContext context) onItemTapped;
  final void Function(dynamic data) assignFetchData;
  const Dashboard({super.key, required this.dashboard,
    required this.onItemTapped, required this.assignFetchData});


  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> with SingleTickerProviderStateMixin {
  final Dio _dio = Dio();

  double progress = 0.0;
  // late List<dynamic> allTask = widget.dashboard["allTasks"];
  final List<Map<dynamic, dynamic>> allTask = [
    {
      "todoItemId": 1,
      'taskType': {'icon': '', 'color': '', 'typeName': 'Office Project'},
      'title': 'Grocery shopping app design',
      'description': 'Doing app design',
      'startDate': "2025-04-07T16:04",
      'endDate': "2025-04-07T16:05",
      'taskStatus': 'Pending',
      'progress': 0.0,
      "userId": 1
    },
    {
      "todoItemId": 2,
      'taskType': {'icon': '', 'color': '', 'typeName': 'Personal Project'},
      'title': 'Uber Eats redesign app challenge',
      'description': 'Doing app design',
      'startDate': "2025-04-07T14:47",
      'endDate': "2025-04-07T14:50",
      'taskStatus': 'Pending',
      'progress': 0.0,
      "userId": 1
    }
  ];

  List<Map<dynamic, dynamic>> inProgressTask = [];
  Timer? timer;
  DateTime _parseDateTime(String dateTimeStr) {
    try {

      final parts = dateTimeStr.split("T");
      if (parts.length != 2) {
        throw FormatException('Invalid datetime format - missing T separator $dateTimeStr');
      }

      // Parse date part (YYYY-MM-DD)
      final dateParts = parts[0].split('-');
      if (dateParts.length != 3) {
        throw FormatException('Invalid date format - expected YYYY-MM-DD');
      }

      // Parse time part (HH:MM)
      final timeParts = parts[1].split(':');
      if (timeParts.length != 2) {
        throw FormatException('Invalid time format - expected HH:MM');
      }

      return DateTime(
        int.parse(dateParts[0]), // year
        int.parse(dateParts[1]), // month
        int.parse(dateParts[2]), // day
        int.parse(timeParts[0]), // hour
        int.parse(timeParts[1]), // minute
      );
    } catch (e) {
      print('Error parsing datetime "$dateTimeStr": $e');
      // Return current time as fallback or throw to handle upstream
      return DateTime.now();
      // OR throw FormatException('Invalid datetime format: $dateTimeStr');
    }
  }

// Calculate progress for a single task
  double _calculateTaskProgress(DateTime start, DateTime end) {
    final now = DateTime.now();
    if (now.isBefore(start)) return 0.0;
    if (now.isAfter(end)) return 100.0;
    return now.difference(start).inMilliseconds / end.difference(start).inMilliseconds * 100;
  }

// Update all tasks' progress and manage inProgressTask list
  void _updateTasksProgress() {
    final now = DateTime.now();

    // 1️⃣ FIRST: Mark completed tasks in API (before removing them)
    for (final task in inProgressTask) {
      final endTime = _parseDateTime(task['endDate']);
      if (now.isAfter(endTime)) {
        markAsCompleteApi(task['todoItemId'], task["userId"]);
        task['taskStatus'] = 'Completed';
      }
    }

    // 2️⃣ THEN: Remove completed tasks from inProgress list
    inProgressTask.removeWhere((task) {
      final end = _parseDateTime(task['endDate']);
      return now.isAfter(end);
    });

    // 3️⃣ Update existing in-progress tasks
    for (var task in inProgressTask) {
      final start = _parseDateTime(task['startDate']);
      final end = _parseDateTime(task['endDate']);
      task['progress'] = _calculateTaskProgress(start, end);
    }

    // 4️⃣ Add new tasks that should be in progress
    for (var task in allTask) {
      final start = _parseDateTime(task['startDate']);
      final end = _parseDateTime(task['endDate']);

      if (now.isAfter(start) && now.isBefore(end)) {
        bool exists = inProgressTask.any((t) =>
        t['title'] == task['title'] && t['startDate'] == task['startDate']);

        if (!exists) {
          final newTask = Map<dynamic, dynamic>.from(task);
          newTask['progress'] = _calculateTaskProgress(start, end);
          newTask['taskStatus'] = 'In Progress';
          inProgressTask.add(newTask);
        }
      }
    }

    setState(() {});
  }
  void startTracking() {
    _updateTasksProgress();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTasksProgress();
    });
  }

  void dispose() {
    timer?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    startTracking();
    super.initState();
  }
  late dynamic dashboard = widget.dashboard;

  @override
  Widget build(BuildContext context) {
    dynamic user  = dashboard["user"];
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            InkWell(
              onTap: (){
                widget.onItemTapped(4, context);
              },
              child:
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/profile_img.jpg'), // Replace with your image asset
            ),
            ),
            SizedBox(width: 12), // Space between the image and column

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 'ello' text
                Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                // 'Livia Vaccaro' text
                Text(
                  user["username"],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            Spacer(), // Push the notification icon to the far right

            // Notification icon with orange dot badge
            InkWell(
              onTap: (){
                widget.onItemTapped(3, context);
              },
              child: Stack(
                clipBehavior: Clip.none, // Allows the orange dot to be partially outside the stack
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
            )

          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.21 ,
            decoration: BoxDecoration(
              color: Color(0xff5f33e1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(padding: EdgeInsets.only(right: 12),
                child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // FractionallySizedBox(
                // widthFactor: 0.7,
                //   child:
                  Column(
                      children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child:
                      AutoSizeText(
                        '${dashboard["totalCompleted"]["message"]}',
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.050, color: Colors.white),
                      ),
                  ),
                      SizedBox(height: 20,),

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(right: 30),
                        child:
                        SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: ElevatedButton(
                          onPressed: () {
                          widget.onItemTapped(1, context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFeee9ff), // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          child:
                          AutoSizeText(
                            'View Task',
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.050,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9260F4),
                            ),
                            maxLines: 1,  // The text will shrink to fit within this limit
                          ),
                        ),
                        ),
        ),
              ],
            ),
                // SizedBox(width: 15,),
                Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: CustomPaint(
                        painter: _DashboardCircularProgressPainter(double.parse(dashboard["totalCompleted"]["completedTask"])),
                      ),
                    ),
                    // Display percentage in the center
                    Text(
                      "${int.parse(dashboard["totalCompleted"]["completedTask"])}%",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ],
      )
      )
      ),
          SizedBox(height: 20),
          Row(
            children: [
              AutoSizeText(
                'In Progress  ',
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.050,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 1,  // The text will shrink to fit within this limit
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.05,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0xffF2EDFF),
                  shape: BoxShape.circle,
                ),
                child: Center(child: AutoSizeText(inProgressTask.length.toString(), style: TextStyle(
                  color: Color(0xFF9260F4)
                ),),)
              ),
            ],
          ),

          inProgressTask.length != 0 ? Align(
              alignment: Alignment.centerLeft,
              child:
          SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [

        Row(
          children: List.generate(inProgressTask.length, (index) {

            final task = inProgressTask[index]; // Current task
            dynamic taskType = task['taskType'];
            return GestureDetector(
              onTap: () {
                ViewTaskScreen(
                    primaryColor:  taskType['color'],
                    icon: taskType['icon'],
                    taskStatus: task['taskStatus'],
                    taskType: taskType['typeName'],
                    taskName: task['title'],
                    description: task['description'],
                    startDate: task['startDate'],
                    endDate: task['endDate'],
                    startTime: task['startTime'],
                    endTime: task['endTime']);
              },
                child: inProgress(
                  task['taskType']['typeName'],
                  task['title'],
                  task['progress'],
                  context,
                  task['taskType']['icon'],
                  task['taskType']['color'],
            )
            // inProgress(
            //   icon: task['taskType']['icon'],
            //   color: task['taskType']['color'],
            //   projectType: task['taskType']['typeName'],
            //   taskName: task['title'],
            //   progress: task['progress'],
            //   context: context,
            // )
            );
          }),
            )


            // inProgress(
            //     icon: '',
            //     color: '',
            //     projectType: "Office Project",
            //     taskName: "Grocery shopping app design",
            //     progress: 10,
            //     context: context),
            //
            // inProgress(
            //     icon: '',
            //     color: '',
            //     projectType: "Personal Project",
            //     taskName: "Uber Eats redesign app challenge",
            //     progress: 20,
            //     context: context),
          ],
        ),
      )
      ):
          Align(
          alignment: Alignment.center,
          child:
          SvgPicture.asset("./assets/box.svg"),
      ),

          SizedBox(height: 15,),
          Row(
            children: [
              AutoSizeText(
                'Task Group  ',
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.050,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 1,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Color(0xffF2EDFF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: AutoSizeText(dashboard["taskGroupSize"].toString(), style: TextStyle(
                      color: Color(0xFF9260F4)
                  ),),)
              ),
            ],
          ),
          SizedBox(height: 7,),
            Expanded(child:
            SingleChildScrollView(
              child:Container(
                child:  Column(
                children: List.generate(dashboard['groupedTask'].length, (index) {
                   dynamic group = dashboard['groupedTask'][index];
                  return taskGroup(
                        // icon: '',
                        // color: '',
                        // groupName: "Health and Fitness Project",
                        // groupSize: "10",
                        // context: context,
                        // progress: 10);
                    icon: group['icon'],
                    color: group['color'],
                    groupName: group['typeName'],
                    groupSize: group['taskSizeInProject'].toString(),
                    context: context,
                    progress: double.parse(group['completedTask']),
                  );
                }),
              ),

              // taskGroup(
                  //   icon: '',
                  //   color: '',
                  //   groupName: "Health and Fitness Project",
                  //   groupSize: "10",
                  //   context: context,
                  //   progress: 10
                  // ),
            ),
          ),
        )



        ]
        ),
   )));
  }

  Future<void> markAsCompleteApi(taskId, userId) async {
    try {
      print(' _-------------------_____in mark as completed block for task $taskId');
      // Add a 10-second timeout to the API call
      final Response response = await _dio.post(
        '$baseUrl$markAsComplete$taskId/$userId', // Params in URL
        options: Options(
          contentType: Headers.jsonContentType, // Optional: Only if API expects JSON
        ),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException("Request timed out after 5 seconds"),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        print('this si the data i recieved $data');
        setState(() {
          dashboard =  data["dashboard"];
        });
        widget.assignFetchData(response.data); // Trigger UI update if needed
      } else {
        print("Failed to mark task as complete: ${response.statusCode}");
      }
    } on TimeoutException catch (_) {
      // Handle timeout (show Retry/Exit dialog)
      _showTimeoutDialog(context, taskId, userId);
    } catch (e) {
      // Handle other errors (network, etc.)
      await _handleNetworkError(context, taskId, userId);
    }
  }

  void _showTimeoutDialog(BuildContext context, taskId, userId) {
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
            markAsCompleteApi(taskId, userId); // Retry
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

Future<void> _handleNetworkError(BuildContext context, taskId, userId) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            title: Text("No Network Connection"),
            content: Text("Please check your internet connection."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  markAsCompleteApi(taskId, userId); // Retry
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
    markAsCompleteApi(
        taskId, userId); // Retry if the error wasn't a network issue
  }
}
}

taskGroup({
  required dynamic icon,
  required dynamic color,
  required String groupName,
  required String groupSize,
  required BuildContext context,
  required double progress
}){
  String proj = groupName.toLowerCase();
  Color progressBackgroundColor = Color(0xffFFE4F2);
  Color progressColor = Color(0xffF478B8);
  Image iconSvg = Image.asset('assets/office.svg');;

  if (icon == null && color == null){
    progressBackgroundColor = lightenColor(iconAndColorDetermine(proj)['color'],  0.70);
    iconSvg = Image.asset(iconAndColorDetermine(proj)['icon']);
    progressColor = (iconAndColorDetermine(proj)['color']);
  } else{
    progressBackgroundColor = hexToColor(color);
    progressColor = hexToColor(color);
    // iconSvg = byteToSvg(icon);
  }
  double mediaQw = MediaQuery.of(context).size.width;
  double mediaQh = MediaQuery.of(context).size.height;

  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ProjectTask(taskType: 'groupName',)));
    },
      child: Column(children: [
    Container(
    padding: EdgeInsets.only(top: 14, bottom: 14, left: 17, right: 17),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    child: Row(
      children: [
        Container(
          width: mediaQw * 0.12,
          height: mediaQh * 0.052,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: progressBackgroundColor
          ),
          child: Center(child: iconSvg,),
        ),
        SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(groupName, style: TextStyle(
              fontSize: 18
            ),),
            AutoSizeText("${groupSize} Tasks", style: TextStyle(
              fontSize: 15,
              color: Colors.black.withOpacity(0.50),
            ),),
          ],
        ),

        Spacer(),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 42,
              height: 42,
              child: CustomPaint(
                painter: _TaskGroupCircularProgressPainter(progress,  progressColor, progressBackgroundColor),
              ),
            ),
            // Display percentage in the center
            Text(
              "${progress.toInt()}%",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),




      ],
  )
  ),
  SizedBox(height: 10,)],));
}

int colorRandomNumber = Random.secure().nextInt(5);
inProgress(
   String projectType,
   String taskName,
   double progress,
   BuildContext context,
   String icon,
   String color,
){
  String proj = projectType.toLowerCase();


Color iconBackgroundColor = Color(0xffFFE4F2);
  Image iconSvg = Image.asset('assets/office.svg', color: Color(0xffF478B8),);;


if (icon.isEmpty && color.isEmpty){
iconBackgroundColor = lightenColor(iconAndColorDetermine(proj)['color'],  0.70);
iconSvg = Image.asset(iconAndColorDetermine(proj)['icon']);

} else{
  print("+++++++++++++++\nthe if statement is at else block");
  iconBackgroundColor = hexToColor(color);
  // iconSvg = byteToSvg(icon);
}

  List<Color> inProgProgressColor  = [Color(0xff0087FF),
    Color(0xffFF7D53),
    Color(0xff9260F4),
    Color(0xffF478B8),
    Color(0xffFFD12E), ];
    Color inProgBackgroundColor =  lightenColor(inProgProgressColor[colorRandomNumber],
        0.85);
  // List<Color> inProgBackgroundColor = [Color(0xffE7F3FF),
  //   Color(0xffFFE9E1),
  //   Color(0xffF9F5FF),  Color(0xffFFF6D4),
  //   Color(0xffEEE9FF), ];

  double mediaQH = MediaQuery.of(context).size.height;
  double mediaQw = MediaQuery.of(context).size.width;
    return  Container(
      width: mediaQH * 0.30,
      height: MediaQuery.of(context).size.height * 0.17,
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: inProgBackgroundColor
      ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(children: [
      Text(projectType, style: TextStyle(color: Colors.grey, fontSize:  14),),
      Spacer(),
      Container(
        width: mediaQw * 0.08,
        height: mediaQH * 0.034,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          color: iconBackgroundColor
        ),
        child: Center(child: iconSvg,),
      )
  ],),
    SizedBox(height: 15,),
    Container(
      height: mediaQH * 0.065,
      child: Text(taskName, style: TextStyle(fontSize: 18), softWrap: true, maxLines: 2,),
    ),

    SizedBox(height: 12,),

  SizedBox(
  width: double.infinity,
    child:
    CustomPaint(
      painter: _HorizontalLineProgressPainter(progress, inProgProgressColor[colorRandomNumber]),
    ),
  )
  ],
  ),
    );
}

SvgPicture byteToSvg(String icon) {
  // return SvgPicture.memory(
    // Uint8List.fromList(), // Convert List<int> to Uint8List
    // placeholderBuilder: (context) => CircularProgressIndicator(),
    // width: 100,
    // height: 100,
  // );
  return SvgPicture.asset("");
}


  Color hexToColor(String hexColor) {
    if (hexColor.startsWith("#")) {
      hexColor = hexColor.replaceAll('#', '');
    }
    int hexInt = int.parse(hexColor, radix: 16);

    if (hexColor.length == 6) {
      hexInt = 0xFF000000 | hexInt;
    }

    return Color(hexInt);
  }

// work on it later let it return sting not svg
Map<String, dynamic> iconAndColorDetermine(String projectType) {
  String proj = projectType.toLowerCase();

  if (proj.contains('office')) {
    return {'icon': 'assets/office.png', 'color': Color(0xffF478B8)};
  } else if (proj.contains('personal')) {
    return {'icon': 'assets/person.png', 'color': Color(0xff9260F4)};
  } else if  (proj.contains('study')) {
    return {'icon': 'assets/study.svg', 'color': Color(0xffFF9142)};
  }else{
    return {'icon': 'assets/office.png', 'color': Color(0xffF478B8)};
  }
}


Color lightenColor(Color color, double amount) {
  return Color.lerp(color, Colors.white, amount)!;
}


class _DashboardCircularProgressPainter extends CustomPainter {
  final double progress;

  _DashboardCircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Color(0xff8764FF)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = Color(0xffEEE9FF)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = min(size.width / 2, size.height / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw the progress arc with rounded caps
    double sweepAngle = (progress / 100) * 2 * pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class _TaskGroupCircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressBackgroundColor;
  final Color progressColor;
  _TaskGroupCircularProgressPainter(this.progress, this.progressBackgroundColor, this.progressColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = progressBackgroundColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = min(size.width / 2, size.height / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw the progress arc with rounded caps
    double sweepAngle = (progress / 100) * 2 * pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}




class _HorizontalLineProgressPainter extends CustomPainter {
  final double progress; // Progress is a percentage from 0 to 100
  final Color progressColor;
  _HorizontalLineProgressPainter(this.progress, this.progressColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Color(0xfffffffF) // Background color (greyish)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded caps at the start and end

    Paint progressPaint = Paint()
      ..color = progressColor // Progress color (purple)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded caps for progress

    // Draw the full background horizontal line
    Offset start = Offset(0, size.height / 2); // Left side of the line
    Offset end = Offset(size.width, size.height / 2); // Right side of the line
    canvas.drawLine(start, end, backgroundPaint);

    // Draw the progress line (proportional to the progress value)
    double progressWidth = (progress / 100) * size.width;
    Offset progressEnd = Offset(progressWidth, size.height / 2);
    canvas.drawLine(start, progressEnd, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

