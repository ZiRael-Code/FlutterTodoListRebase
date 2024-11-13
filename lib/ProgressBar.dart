import 'package:flutter/material.dart';

void main() {

  runApp(ColorReducer());
}

class  ColorReducer extends StatefulWidget{
  const ColorReducer({super.key});
  @override
  States createState() => States();
}

class States extends State<ColorReducer>{
  Color originalColor = Color(0xffF478B8);
late Color lighterColor ;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    lighterColor = lightenColor(originalColor,  0.85);
  }

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Lighter Color Example')),
        body: Container(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: originalColor),
              ),
              SizedBox(height: 20,),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: lighterColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

Color lightenColor(Color color, double amount) {
  // amount is between 0 and 1, where 0 is the original color and 1 is white.
  return Color.lerp(color, Colors.white, amount)!;
}
