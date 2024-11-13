import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main(){
  runApp(Notifications());
}

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  @override
  _AppointmentPaymentScreen createState() => _AppointmentPaymentScreen();
}

class _AppointmentPaymentScreen extends  State<Notifications> {
  List<String> isSelected = [];
  bool isPendingSelected = false;
  bool isCheckedSelected = false;

  List<Map<String, String>> contact = [
    {
      'name':'John Doe',
      'phone':'1234567890',
    }, {
      'name':'John Doe',
      'phone':'1234567890',
    }, {
      'name':'John Doe',
      'phone':'1234567890',
    }, {
      'name':'John Doe',
      'phone':'1234567890',
    }, {
      'name':'John Doe',
      'phone':'1234567890',
    },

  ];



  List<Map<dynamic, dynamic>> all_notification = [
    {
      'from':'ZiReal System',
      'body': [
        {
          'title':'hello this is a gentle reminder that your father neva pay load',
          'time': '10:00 AM',
          'checked': true
        },
        {
          'title':'Oga shey u don chop this morning nii',
          'time': '9:00 AM',
          'checked': false
        }
      ],
      'pending': false,
    },
    {
      'from': 'Jehovah Witness',
      'body': [
        {
          'title':'This is a reminder that you need to pay your rent',
          'time': '11:00 AM',
          'checked': false
        },
        {
          'title':'This is a reminder that God is watching you always 👁️',
          'time': '10:30 AM',
          'checked': false
        }
      ]
    },
    {
      'from': 'Tinubu Shettima',
      'body': [
        {
          'title':'I hear say you still dey buy fuel for ₦200',
          'time': '11:00 AM',
          'checked': false
        },
        {
          'title':'I hear say you still dey buy fuel for ₦200',
          'time': '10:30 AM',
          'checked': false
        }
      ]
    },
    {
      'from': 'EFCC',
      'body': [
        {
          'title':'This is a reminder that you need to pay your rent',
          'time': '11:00 AM',
          'checked': false
        },
        {
          'title':'How far pablo abeg where our house dey i don forget',
          'time': '10:30 AM',
          'checked': false
        }
      ]
    },
    {
      'from': 'Palmpay',
      'body': [
        {
          'title':'Hello baby it me abike please what is you location',
          'time': '11:00 AM',
          'checked': false
        },
        {
          'title':'Hello baby it me abike please what is you location',
          'time': '10:30 AM',
          'checked': false
        }
      ]
    }
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
home: Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xFFE5E5E5),
            ),
            child: Center(
              child: Text(
                !isSelected.isEmpty ?
                isSelected.length.toString()
                    : ''
              ),
            )
          ),
          Spacer(),
          Container(
            alignment: Alignment.center,
            child:
            Center(child: Text(
              'Notifications',
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.normal
              ),
            ),
            ),
          ),
          Spacer(),

],
),
centerTitle: true,
),
body:
Container(
padding: EdgeInsets.only(bottom: 30, left: 15, right: 15),
child:
Align(
  child:
  Column(
    children: [
      SizedBox(height: 30),
      Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.green,
                    width: 1),
              ),
              child: Container(
                width: 7.5,
                height: 7.5,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            SizedBox(width: 7),
            Text('Pending', style: TextStyle(color: Color(
                0xff2E2E42)),),
            SizedBox(width: 7),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            SizedBox(width: 7),
            Text('Checked', style: TextStyle(color: Color(
                0xff2E2E42)),),
          ],
        ),
      ),
      SizedBox(height: 25,),
      Align(
          alignment: Alignment.centerLeft,
          child:
          Text('Today', style: TextStyle(fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold))),
      SizedBox(height: 20,),

     Container(
       child: Expanded(child:
       SingleChildScrollView(
         child: Column(
           children:  all_notification.map((notificationData) {
             String from = notificationData['from'];
             bool pending = notificationData.containsKey('pending') ? notificationData['pending'] : false;
             List<dynamic> body = notificationData['body'];

             if (body.isNotEmpty) {
               Map<dynamic, dynamic> latestMessage = body.last;

               String messageTitle = latestMessage['title'];
               String messageTime = latestMessage['time'];
               bool isChecked = latestMessage['checked'];

               return notification(
                 title: from,
                 message: messageTitle,
                 time: messageTime,
                 buttonText: pending ? 'Pending' : 'View',
                 isChecked: isChecked,
               );
             } else {
               return SizedBox.shrink();
             }
           }).toList()

         ),
       )
       ),
     ),
      !isSelected.isEmpty ?
          Column(
            children :[
              SizedBox(height: 20,),
      ElevatedButton(
        onPressed: () {
          // show_ondelete_notification_popup()
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff5F33E0),
          fixedSize: Size.fromWidth(MediaQuery
              .of(context)
              .size
              .width),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 12.0, horizontal: 24.0),
          child: Text(
            'Delete notifications',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      )
    ]
      )
          :
      Container(),


    ],
                  ),
                ))));
  }


  Widget notification({
    required String title,
    required String message,
    required String time,
    required String buttonText,
    required bool isChecked,
  }) {
    bool notSelected = !isSelected.contains(
        title); // Check if the title is in the selection list

    return InkWell(
      onLongPress: () {
        setState(() {
          if (notSelected) {
            isSelected.add(title); // Add title to the selection list
          } else {
            isSelected.remove(title); // Remove title from the selection list
          }
          notSelected = !notSelected; // Toggle the selection status
        });
      },
      child: Stack(
        children: [
          // Notification Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Small Dot
                  isChecked
                      ? Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Container(
                        width: 7.5,
                        height: 7.5,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  )
                      : Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(width: 7),
                  // Notification Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child:
                        Text(
                          message,
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              time,
                              style: TextStyle(
                                color: Color(0xff5F33E0),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
    // Button
    Align(
      alignment: Alignment.centerRight,
      child:
                  SizedBox(
                    height: 29,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isSelected = [""]; // Reset the selection list
                        });
                        // Add your onPressed functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xff5F33E0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Divider(color: Colors.black12,),
              SizedBox(height: 10),
            ],
          ),
          // Checkmark Icon (Visible only if selected) - Positioned at the top right
          if (!notSelected)
            Positioned(
              top: 0,
              // Adjust the position to ensure it does not clash with the button
              right: 0,
              // Add padding from the right to prevent overlap
              child: Container(
                padding: EdgeInsets.all(2),
                // width: 18,
                // height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 12),
              ),
            ),
        ],
      ),
    );
  }
}











