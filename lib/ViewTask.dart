import 'dart:io';

import  'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_list_flutter/Dashboard.dart';
import 'package:todo_list_flutter/Notifications.dart';



class ViewTaskScreen extends StatefulWidget{
  final dynamic icon;
  final dynamic primaryColor;
  final String taskType;
  final String taskName;
  final String description;
  final String startDate;
  final String taskStatus;
  final String endDate;
  final String startTime;
  final String endTime;


  const ViewTaskScreen({
    super.key,
     required this.primaryColor,
    required this.icon,
    required this.taskStatus,
    required this.taskType,
    required this.taskName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime});

  @override
  _AddTaskScreen createState() => _AddTaskScreen();
}

class _AddTaskScreen extends State<ViewTaskScreen> {
  final TextEditingController _taskTypeController = TextEditingController();



 late dynamic realIcon = widget.icon;
 late Color primaryColor = widget.primaryColor;
  late Color colorLightened = lightenColor(primaryColor,  0.70);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'View Task',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 35),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(child:
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black, size: 35,),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Notifications()));
                },
              ),
              Positioned(
                  top: 10,
                  right: 10,
                  child:
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff5f33e0)
                ),
              )
              )
            ],
          ),)

        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           Column(children: [
             Stack(
               children: [
             Container(
               padding: EdgeInsets.all(15),
               child:
             Container(
              height: 165,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                    Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 0.5),
                          color: colorLightened
                      ),
                      child: Center(
                        child: InkWell(
                          child: realIcon,
                      ),
                    ),
                    ),
              ],)
            ),
            ),
             ]
           )

           ],),
            const SizedBox(height: 5),

            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Task type', style: TextStyle(fontSize: 14)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 12, top: 3, bottom: 3),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.7, color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child:  Row(
                      children: [
                        // Office Icon
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: realIcon
                          // SvgPicture.asset(
                          //   imagePath,
                          //   width: 24,
                          //   height: 24,
                          // ),
                        ),
                        // TextField
                        Expanded(
                          child: TextField(
                            controller: _taskTypeController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: widget.taskType,
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,)
                ]
            ),

             inputField(
              label: "Task Name",
              text: widget.taskName,
              icon: Icons.title,
                primaryColor: primaryColor,
            ),

             inputField(
              label: "Description",
              text: widget.description,
              icon: Icons.description,
                primaryColor: primaryColor,
            ),

            Row(
              children:  [
                Expanded(
                  child: inputField(
                    label: "Start date",
                    text: widget.startDate,
                    icon: Icons.calendar_today,
                    primaryColor: primaryColor,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: inputField(
                    label: "End date",
                    text: widget.endDate,
                    icon: Icons.calendar_today,
                      primaryColor: primaryColor,
                  ),
                ),
              ],
            ),

            Row(
              children:  [
                Expanded(
                  child: inputField(
                    label: "Start time",
                    text: widget.startTime,
                    icon: Icons.access_time,
                      primaryColor: primaryColor,

                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: inputField(
                    label: "End time",
                    text: widget.endTime,
                    icon: Icons.access_time,
                    primaryColor: primaryColor,

                  ),
                ),
              ],
            ),

            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Task status', style: TextStyle(fontSize: 14)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 12, top: 3, bottom: 3),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.7, color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child:  Row(
                      children: [
                        // Office Icon
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: realIcon
                          // SvgPicture.asset(
                          //   imagePath,
                          //   width: 24,
                          //   height: 24,
                          // ),
                        ),
                        // TextField
                        Expanded(
                          child: TextField(
                            controller: _taskTypeController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: widget.taskStatus,
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,)
                ]
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5F33E1),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Add your task functionality here
              },
              child: const Text(
                "Update Task",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
    );
  }


Color colorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse("0x$hexColor"));
}

inputField  ({
 required String label,
required String text,
required IconData icon,
  required primaryColor,
  controller,
  action
}) {
  if (action != null)
    return InkWell(
      onTap: action,
      child: field(label, text, icon, primaryColor, controller)
    );
  else {
    return field(label, text, icon, primaryColor, controller);
  }
  }

  field (String label, String hintText, IconData icon, primaryColor, dateController){
    return Padding(
      padding: const EdgeInsets.only(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16,),
          ),
          TextField(
            controller: dateController,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              prefixIcon: Icon(icon, size: 25, color: primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
            ),
          ),

          SizedBox(height: 10,)
        ],
      ),
    );
  }


  }