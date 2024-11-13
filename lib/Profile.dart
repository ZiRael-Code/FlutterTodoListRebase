import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


void main(){
  runApp(Profile());
}

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  _AppointmentPaymentScreen createState() => _AppointmentPaymentScreen();
}

class _AppointmentPaymentScreen extends  State<Profile> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xffF2F2F2),
            body: SingleChildScrollView(
                child:
                Column(children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E2E42),
                            ),
                          ),
                          Container(
                            height: 117,
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color(0x0D000000),
                              ),
                            ),
                            child: Row(
                              children: [
                                // ClipOval for round image
                                ClipOval(
                                  child: Image.asset(
                                    'assets/rema.png',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sanni Muiz',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2E2E42), // Text color
                                      ),
                                    ),
                                    SizedBox(height: 8), // Spacing between the two texts
                                    Text(
                                      'johndoe@gmail.com', // Email text
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff9260F4), // Blue color for the email text
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.topRight,
                                  child:
                                  Container(
                                    alignment:  Alignment.topRight,
                                    width: 27,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff9260F4), // Blue background
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.edit, // Write (edit) icon
                                        color: Colors.white, // White icon color
                                        size: 16, // Adjust the size as needed
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 30,),

                        ],
                      )
                  ),

                  Container(
                    padding:  EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    child: Text(
                      'Personal Details',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                    ,
                  ),

                  Container(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                          children: [
                            details(
                                icon: Icons.person,
                                detailType: "username",
                                detailInfo: "Sanni Muiz Dolapo",
                                shouldLine: true
                            ),

                            details(
                                icon: Icons.email,
                                detailType: "Email Address",
                                detailInfo: "johndoe@gmail.com",
                                shouldLine: true
                            ),

                            detailsNoCol(
                                icon: Icons.lock_open,
                                detailInfo: "Change Password",
                                shouldLine: true
                            ),

                          ]
                      )
                  ),

                  Container(
                    padding:  EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    child: Text(
                      'Referrals',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                    ,
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                    detailsNoCol(
                        icon: Icons.link,
                        detailInfo: "Refer someone",
                        shouldLine: false
                    ),
                  ),

                  Container(
                    padding:  EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    child:
                    Text(
                      'Help and support',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Container(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                          children: [
                            detailsNoCol(
                                icon: Icons.headset_mic_outlined,
                                detailInfo: "Customer care",
                                shouldLine: true
                            ),
                            SizedBox(height: 25,),
                            detailsNoCol(
                                icon: Icons.question_mark,
                                detailInfo: "FAQs",
                                shouldLine: true
                            ),
                            SizedBox(height: 25,),
                            detailsNoCol(
                                icon: Icons.receipt,
                                detailInfo: "Blogs & articles",
                                shouldLine: true
                            ),
                            SizedBox(height: 25,),
                            detailsNoCol(
                                icon: Icons.search,
                                detailInfo: "How it works",
                                shouldLine: false
                            ),
                          ]
                      )
                  ),

                  SizedBox(height: 20,),

                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                    ),
                    child:  detailsNoCol(
                        icon: Icons.exit_to_app,
                        detailInfo: "Logout",
                        shouldLine: false,
                        lol: "true"
                    ),
                  ),


                  SizedBox(height: 20,)

                ]
                )

            )));
  }

  details({

    required IconData icon,
    required String detailType,
    required String detailInfo,
    required bool shouldLine
  }) {
    return Column(children: [
      Row(
        children: [
          Container(
              width: 41,
              height: 41,
              decoration: BoxDecoration(
                color: Color(0xff9260F4).withOpacity(0.20),
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(icon, size: 28, color: Color(0xff9260F4)),)
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(detailType, style: TextStyle(color: Colors.grey, fontSize: 14),),
              Text(detailInfo, style: TextStyle(color: Colors.black, fontSize:18))
            ],
          )

        ],
      ),
      SizedBox(height: 10),
      SvgPicture.asset(shouldLine == true ? "assets/images/line.svg": ""),
      SizedBox(height: 15),
    ]
    );
  }



  detailsNoCol({
    required IconData icon,
    required String detailInfo,
    required bool shouldLine,
    lol
  }) {
    return Column(children: [
      Row(
        children: [
          Container(
              width: 41,
              height: 41,
              decoration: BoxDecoration(
                color: lol == null ? Color(0xff9260F4).withOpacity(0.20) : Colors.red.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(icon, size: 28, color: lol == null ?  Color(0xff9260F4) : Colors.red),)
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(detailInfo, style: TextStyle(color: lol == null ? Colors.black : Colors.red, fontSize:18, fontWeight: lol == null ? FontWeight.normal : FontWeight.bold))
            ],
          )

        ],
      ),
      SizedBox(height: 10),
      SvgPicture.asset(shouldLine == true ? "assets/images/line.svg": ""),
    ]
    );
  }
}