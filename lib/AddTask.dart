import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list_flutter/Dashboard.dart';
import 'package:todo_list_flutter/Notifications.dart';

//TODO Write a doc for this because the code is too much

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
  final TextEditingController _startDateInputController = TextEditingController();
  final TextEditingController _endDateInputController = TextEditingController();

   final TextEditingController _startTimeInputController = TextEditingController();
  final TextEditingController _endTimeInputController = TextEditingController();

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
  String startDate = "dd:mm:yy";
  String selectedTime = "hh:mm";

   late String selectedOption = taskType[0];

   @override
   void initState() {
     super.initState();
     _taskTypeController.text = selectedOption;
   }

   String imagePath = 'assets/office.svg';
 late SvgPicture icon = SvgPicture.asset(imagePath, width: 40, height: 40,);
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
                    // TODO change the svg to image start from the dashboard method
                    child: SvgPicture.asset(
                      imagePath,
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


             inputField(
              label: "Task Name",
              hintText: "Build portfolio website...",
              icon: Icons.title,
                primaryColor: primaryColor,
                 isEnabled: true


            ),

             inputField(
              label: "Description",
              hintText: "The website action would...",
              icon: Icons.description,
                primaryColor: primaryColor,
                 isEnabled: true
            ),

            Row(
              children:  [
                Expanded(
                  child: inputField(
                    label: "Start date",
                    hintText: "dd:mm:yy",
                    icon: Icons.calendar_today,
                    primaryColor: primaryColor,
                    isEnabled: false,
                    controller: _startDateInputController,
                    action: (){
                      showDatePickers(_startDateInputController);
                    }
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: inputField(
                    label: "End date",
                    hintText: "dd:mm:yy",
                    icon: Icons.calendar_today,
                      primaryColor: primaryColor,
                      isEnabled: false,
                      controller: _endDateInputController,
                      action: (){
                        showDatePickers(_endDateInputController);
                      }
                  ),
                ),
              ],
            ),

            Row(
              children:  [
                Expanded(
                  child: inputField(
                    label: "Start time",
                    hintText: "hh:mm:ss",
                    icon: Icons.access_time,
                      primaryColor: primaryColor,
                      isEnabled: false,
                    controller: _startTimeInputController,
                    action: () {
                      endTime(_startTimeInputController);
                    }
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: inputField(
                    label: "End time",
                    hintText: "hh:mm:ss",
                    icon: Icons.access_time,
                    primaryColor: primaryColor,
                      isEnabled: false,
                      controller: _endTimeInputController,
                      action: () {
                        endTime(_endTimeInputController);
                      }
                  ),
                ),
              ],
            ),

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
         Map<String, dynamic> icon = iconAndColorDetermine(selectedOption);
         imagePath = icon['icon'];
         primaryColor = icon['color'];
         colorLightened = lightenColor(primaryColor, 0.70);
         //TODO check and change the svg to image
         this.icon = SvgPicture.asset(imagePath, width: 40, height: 40);
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
                        colorLightened = lightenColor(primaryColor, 0.70);
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

  void endTime(_controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final String formattedTime =
          "${pickedTime.hourOfPeriod.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period == DayPeriod.am ? "AM" : "PM"}";

      setState(() {
        selectedTime = formattedTime;
        _controller.text = selectedTime;
      });
    }
  }


  void showDatePickers(controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        startDate =
        "${pickedDate.day.toString().padLeft(2, '0')}:${pickedDate.month.toString().padLeft(2, '0')}:${pickedDate.year.toString().substring(2)}";
        controller.text = startDate;
      });
    }
  }


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
required String hintText,
required IconData icon,
  required primaryColor,
  required bool isEnabled,
  controller,
  action
}) {
  if (action != null)
    return InkWell(
      onTap: action,
      child: field(label, hintText, icon, primaryColor, isEnabled, controller)
    );
  else {
    return field(label, hintText, icon, primaryColor, isEnabled, controller);
  }
  }

  field (String label, String hintText, IconData icon, primaryColor, bool isEnabled,  dateController){
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
            enabled: isEnabled,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              prefixIcon: Icon(icon, size: 25, color: primaryColor),
              suffixIcon: Icon(Icons.edit, color: primaryColor),
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

