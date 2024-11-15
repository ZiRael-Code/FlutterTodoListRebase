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

class AddTaskScreen extends StatefulWidget{
  _AddTaskScreen createState() => _AddTaskScreen();
}

class _AddTaskScreen extends State<AddTaskScreen> {
  final TextEditingController _taskTypeController = TextEditingController();
  bool isEditable = false;
  final List<Map<String, dynamic>> colors = [
    {"name": "Red", "color": Colors.red},
    {"name": "Blue", "color": Colors.blue},
    {"name": "Green", "color": Colors.green},
    {"name": "Yellow", "color": Colors.yellow},
    {"name": "Orange", "color": Colors.orange},
    {"name": "Purple", "color": Colors.purple},
    {"name": "Pink", "color": Colors.pink},
    {"name": "Brown", "color": Colors.brown},
    {"name": "Cyan", "color": Colors.cyan},
    {"name": "Teal", "color": Colors.teal},
  ];
  String selectedColorHex = '';
   List<String> taskType = [
    "Office Project",
    "Daily Studies",
    "Personal Project",
  ];

   late String selectedOption = taskType[0];

   @override
   void initState() {
     super.initState();
     _taskTypeController.text = selectedOption;
   }

  Image icon = Image.asset('assets/office.png', width: 40, height: 40,);
  Color primaryColor = Color(0xfff277b7);
 late Color colorLightened = lightenColor(primaryColor,  0.70);

   @override
  Widget build(BuildContext context) {


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
                        child: icon,
                      ),
                    ),
              ],)
            ),
            ),
             Positioned(
               right: 20,
               bottom: 20,
               child: IconButton(icon: Icon(Icons.edit,
                   color: Colors.white, size: 40),
                 onPressed: () {
                   _showColorPickerDialog();
                 },
                  ),
             ),
             ]
           )

           ],),
            const SizedBox(height: 5),

            // Task Type Input
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
                    child: Image.asset(
                      'assets/office.png', // Add your image to assets folder
                      width: 24,
                      height: 24,
                    ),
                  ),
                  // TextField
                  Expanded(
                    child: TextField(
                      controller: _taskTypeController,
                      readOnly: !isEditable,
                      decoration: const InputDecoration(
                        hintText: "Build a website...",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  // Dropdown Icon
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      _showTaskTypeDropdown();
                    },
                  ),
                  // Edit Icon
                  IconButton(
                    icon: Icon(
                      isEditable ? Icons.check : Icons.edit,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        isEditable = !isEditable;
                      });
                    },
                  ),
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
   void _showTaskTypeDropdown() async {
     String? selected = await showDialog<String>(
       context: context,
       builder: (BuildContext context) {
         return SimpleDialog(
           title: const Text("Select Task Type"),
           children: taskType.map((String option) {
             return SimpleDialogOption(
               onPressed: () {
                 Navigator.pop(context, option);
               },
               child: Text(option),
             );
           }).toList(),
         );
       },
     );

     if (selected != null && selected != selectedOption) {
       setState(() {
         selectedOption = selected;
         _taskTypeController.text = selectedOption;
       });
     }
   }

  void _showColorPickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 345,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Choose a Color",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    final colorItem = colors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColorHex = colorItem['color'].value
                              .toRadixString(16)
                              .padLeft(8, '0')
                              .substring(2)
                              .toUpperCase();
                        });
                        setState(() {
                         primaryColor = colorFromHex(selectedColorHex);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: colorItem['color'],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                colorItem['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Color colorFromHex(String hexColor) {
  // Ensure the hexColor starts with 'FF' if it's not a full 8-char color.
  hexColor = hexColor.replaceAll("#", ""); // Remove '#' if present.
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor"; // Add opacity (alpha) value of 255.
  }
  return Color(int.parse("0x$hexColor"));
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

          SizedBox(height: 10,)
        ],
      ),
    );
  }

