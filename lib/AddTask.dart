import 'package:flutter/material.dart';
import 'package:todo_list_flutter/Dashboard.dart';
import 'package:todo_list_flutter/Notifications.dart';

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

    Image icon = Image.asset('assets/office.png', width: 40, height: 40,);
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
          icon: const Icon(Icons.home, color: Colors.black, size: 35),
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
            // Image Container
           Column(children: [
             Stack(
               children: [
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
                        child: icon,
                      ),
                    ),
              ],)
            ),
             Positioned(
               right: 10,
               bottom: 10,
               child: Icon(Icons.edit, color: Colors.white, size: 45),
             ),
             ]
           )

           ],),
            const SizedBox(height: 20),

            // Task Type Input
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text('Task type', style: TextStyle(fontSize: 14)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(width: 0.7, color: Colors.black),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                children: [

                ],
              ),
            ),
                SizedBox(height: 10,)
            ]
        ),


            // Task Name Input
             inputField(
              label: "Task Name",
              hintText: "Build portfolio website...",
              icon: Icons.title,
                primaryColor: primaryColor,
                 isEnabled: true


            ),

            // Description Input
             inputField(
              label: "Description",
              hintText: "The website action would...",
              icon: Icons.description,
                primaryColor: primaryColor,
                 isEnabled: true
            ),

            // Start and End Date Inputs
            Row(
              children:  [
                Expanded(
                  child: inputField(
                    label: "Start date",
                    hintText: "dd:mm:yy",
                    icon: Icons.calendar_today,
                      primaryColor: primaryColor,
                      isEnabled: false
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: inputField(
                    label: "End date",
                    hintText: "dd:mm:yy",
                    icon: Icons.calendar_today,
                      primaryColor: primaryColor,
                      isEnabled: false


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
                      primaryColor: primaryColor,
                      isEnabled: false

                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: inputField(
                    label: "End time",
                    hintText: "hh:mm:ss",
                    icon: Icons.access_time,
                    primaryColor: primaryColor,
                      isEnabled: false
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
                  backgroundColor: Color(0xff5F33E1),
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
  required primaryColor,
  required bool isEnabled,
  action
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
            enabled: isEnabled,
            decoration: InputDecoration(
              filled: true, // Enable background fill
              fillColor: Colors.white, // Set the fill color to white
              hintText: hintText,
              prefixIcon: Icon(icon, size: 25, color: primaryColor),
              suffixIcon: Icon(Icons.edit, color: primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey), // Set border color if needed
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey), // Color for the enabled border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primaryColor, width: 2), // Color for the focused border
              ),
            ),
          ),

          SizedBox(height: 15,)
        ],
      ),
    );
  }

