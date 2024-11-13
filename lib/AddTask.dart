import 'package:flutter/material.dart';
import 'package:todo_list_flutter/Dashboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddTaskScreen(),
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Image icon = Image.asset('assets/office.png');
    Color primaryColor = Color(0xfff277b7);
    Color colorLightened = lightenColor(primaryColor,  0.70);


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Add Task',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.black, size: 40),
          onPressed: () {},
        ),
        actions: [
          Container(child: 
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black, size: 40,),
                onPressed: () {},
              ),
              Positioned(
                  top: 0,
                  right: 0,
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
          children: [
            // Image Container
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 0.5),
                      color: colorLightened
                    ),
                  child: Center(
                    child: icon,
                  ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Icon(Icons.edit, color: primaryColor, size: 45),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Task Type Input
            Container(

            ),


            // Task Name Input
             inputField(
              label: "Task Name",
              hintText: "Build portfolio website...",
              icon: Icons.title,
                primaryColor: primaryColor

            ),

            // Description Input
             inputField(
              label: "Description",
              hintText: "The website action would...",
              icon: Icons.description,
                primaryColor: primaryColor
            ),

            // Start and End Date Inputs
            Row(
              children:  [
                Expanded(
                  child: inputField(
                    label: "Start date",
                    hintText: "dd:mm:yy",
                    icon: Icons.calendar_today,
                      primaryColor: primaryColor
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: inputField(
                    label: "End date",
                    hintText: "dd:mm:yy",
                    icon: Icons.calendar_today,
                      primaryColor: primaryColor

                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Start and End Time Inputs
            Row(
              children:  [
                Expanded(
                  child: inputField(
                    label: "Start time",
                    hintText: "hh:mm:ss",
                    icon: Icons.access_time,
                      primaryColor: primaryColor
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: inputField(
                    label: "End time",
                    hintText: "hh:mm:ss",
                    icon: Icons.access_time,
                    primaryColor: primaryColor
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Add Task Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Add Task",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


inputField  ({
 required String label,
required String hintText,
required IconData icon,
  required primaryColor
}) {
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
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: hintText,
              prefixIcon: Icon(icon, size: 35, color: primaryColor),
              suffixIcon: Icon(Icons.edit, color: primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }