import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Chat extends StatefulWidget {
  final dynamic chat;
  Chat({required this.chat});

  @override
  _Chat createState() => _Chat();
}

class _Chat extends  State<Chat> {
  String? _selectedValue;
  late dynamic _chat = widget.chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Column(children: [
                  Text(_chat['from'], style: TextStyle(fontSize: 18),),
                ],),),
              Spacer(),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Color(0xffE2EDFF),
                    shape: BoxShape.circle
                ),
                child: Icon(Icons.more_horiz_rounded, color: Colors.blue,),
              )
            ],
          ),
          centerTitle: true,
        ),
        body:

        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 25),
          child:
          Column(
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Expanded(
                    child:
                    Column(
                        children: [
                          SizedBox(height: 20),


                    Column(
                      children: List.generate(_chat['body'].length, (index) {
                        dynamic bodyData = _chat['body'][index];
                        return   incomingMessage(
                            text: bodyData['title'],
                            date: bodyData['date'],
                        );

                  }),),


                          // incomingMessage(
                          //     text: 'Oh, I see. Sorry about that. Please click on the blue icon at the bottom right of your screen to select your symptoms.',
                          //     date: 'Wed 8:21 AM'
                          // ),
                          // incomingMessage(
                          //     text: 'Use these medications',
                          //     date: 'Wed 8:21 AM'
                          // ),
                          // Spacer(),
                        ]),
                  )
              ),
            ],
          ),


        ));
  }

  incomingMessage({
    required String text,
    required String date,
  }) {
    return Container(
      child: Column(
        children: [

          Text(date),
          SizedBox(height: 20),

          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.80,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F4F5),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      softWrap: true, // Ensure the text wraps when needed
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 35),
        ],
      ),
    );
  }


}