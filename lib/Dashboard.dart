import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(Dashboard());
}

class  Dashboard extends StatefulWidget{
  const Dashboard({super.key});


  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> with SingleTickerProviderStateMixin {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Customize app bar color
        title: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/profile_img.jpg'), // Replace with your image asset
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
                  'Nwaloziri Israel',
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
            Stack(
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
            height: MediaQuery.of(context).size.height * 0.2 ,
            decoration: BoxDecoration(
              color: Color(0xff5f33e1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
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
                        'Your today\'s task almost done!',
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
                          setState(() {
                            // progress = 0;
                            if (progress < 100) {
                              progress += 10;
                            }
                          });
                            // Handle signup logic
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

                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: CustomPaint(
                        painter: _DashboardCircularProgressPainter(progress),
                      ),
                    ),
                    // Display percentage in the center
                    Text(
                      "${progress.toInt()}%",
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
                child: Center(child: AutoSizeText('6', style: TextStyle(
                  color: Color(0xFF9260F4)
                ),),)
              ),
            ],
          ),

          Align(
              alignment: Alignment.centerLeft,
              child:
          SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            inProgress(
                icon: '',
                color: '',
                projectType: "Office Project",
                taskName: "Grocery shopping app design",
                progress: 10,
                context: context),

            inProgress(
                icon: '',
                color: '',
                projectType: "Personal Project",
                taskName: "Uber Eats redesign app challenge",
                progress: 20,
                context: context),
          ],
        ),
      )
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
                  child: Center(child: AutoSizeText('4', style: TextStyle(
                      color: Color(0xFF9260F4)
                  ),),)
              ),
            ],
          ),
          SizedBox(height: 7,),

            Expanded(child:
            SingleChildScrollView(
              child:Container(child:  Column(
                children: [
                  taskGroup(
                    icon: '',
                    color: '',
                    groupName: "Personal Project",
                    groupSize: "12",
                    context: context,
                    progress: 10
                  ),
                  taskGroup(
                    icon: '',
                    color: '',
                    groupName: "Business Project",
                    groupSize: "15",
                    context: context,
                    progress: 15
                  ),
                  taskGroup(
                    icon: '',
                    color: '',
                    groupName: "Study Project",
                    groupSize: "8",
                    context: context,
                    progress: 8
                  ),
                  taskGroup(
                    icon: '',
                    color: '',
                    groupName: "Art Project",
                    groupSize: "18",
                    context: context,
                    progress: 18
                  ),
                  // taskGroup(
                  //   icon: '',
                  //   color: '',
                  //   groupName: "Health and Fitness Project",
                  //   groupSize: "10",
                  //   context: context,
                  //   progress: 10
                  // ),
                ],
            ),
            ),
          ),
        )



        ]
        ),
   )));
  }
}

taskGroup({
  required String icon,
  required String color,
  required String groupName,
  required String groupSize,
  required BuildContext context,
  required double progress
}){
  String proj = groupName.toLowerCase();
  Color progressBackgroundColor = Color(0xffFFE4F2);
  Color progressColor = Color(0xffF478B8);
  SvgPicture iconSvg = SvgPicture.asset('assets/office.svg');;

  if (icon.isEmpty && color.isEmpty){
    progressBackgroundColor = lightenColor(iconAndColorDetermine(proj)['color'],  0.70);
    iconSvg = SvgPicture.asset(iconAndColorDetermine(proj)['icon']);
    progressColor = (iconAndColorDetermine(proj)['color']);
  } else{
    progressBackgroundColor = hexToColor(color);
    progressColor = hexToColor(color);
    iconSvg = byteToSvg(icon);
  }
  double mediaQw = MediaQuery.of(context).size.width;
  double mediaQh = MediaQuery.of(context).size.height;

  return Column(children: [
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
  SizedBox(height: 10,)],);
}

inProgress({
  required String projectType,
  required String taskName,
  required double progress,
  required BuildContext context,
  required String icon,
  required String color,
}){
  String proj = projectType.toLowerCase();


Color iconBackgroundColor = Color(0xffFFE4F2);
SvgPicture iconSvg = SvgPicture.asset('assets/office.svg', color: Color(0xffF478B8),);;


if (icon.isEmpty && color.isEmpty){
iconBackgroundColor = lightenColor(iconAndColorDetermine(proj)['color'],  0.70);
iconSvg = SvgPicture.asset(iconAndColorDetermine(proj)['icon']);

} else{
  print("+++++++++++++++\nthe if statement is at else block");
  iconBackgroundColor = hexToColor(color);
  iconSvg = byteToSvg(icon);
}
  int colorRandomNumber = Random.secure().nextInt(5);
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

hexToColor(String color){
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
}

// work on it later let it return sting not svg
Map<String, dynamic> iconAndColorDetermine(String projectType) {
  String proj = projectType.toLowerCase();

  if (proj.contains('office')) {
    return {'icon': 'assets/office.svg', 'color': Color(0xffF478B8)};
  } else if (proj.contains('personal')) {
    return {'icon': 'assets/person.svg', 'color': Color(0xff9260F4)};
  } else if  (proj.contains('study')) {
    return {'icon': 'assets/study.svg', 'color': Color(0xffFF9142)};
  }else{
    return {'icon': 'assets/office.svg', 'color': Color(0xffF478B8)};
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

