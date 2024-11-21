import 'dart:async';
import 'package:flutter/material.dart';

class AlarmProgressExample extends StatefulWidget {
  @override
  _AlarmProgressExampleState createState() => _AlarmProgressExampleState();
}

class _AlarmProgressExampleState extends State<AlarmProgressExample> {
  DateTime startDateTime = DateTime(2024, 11, 21, 11, 46);
  DateTime endDateTime = DateTime(2024, 11, 21, 11, 48);
  double percentage = 0.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _calculateInitialProgress();
    _startTimer();
  }

  void _calculateInitialProgress() {
    DateTime now = DateTime.now();

    // If the current time is before the start time, progress is 0
    if (now.isBefore(startDateTime)) {
      percentage = 0.0;
    }
    // If the current time is after the end time, progress is 100
    else if (now.isAfter(endDateTime)) {
      percentage = 100.0;
    }
    // Otherwise, calculate progress based on elapsed time
    else {
      Duration totalDuration = endDateTime.difference(startDateTime);
      Duration elapsedDuration = now.difference(startDateTime);
      percentage = (elapsedDuration.inMilliseconds / totalDuration.inMilliseconds) * 100;
    }

    setState(() {});
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();

      // Update progress only if within the start and end times
      if (now.isBefore(endDateTime)) {
        Duration totalDuration = endDateTime.difference(startDateTime);
        Duration elapsedDuration = now.difference(startDateTime);

        setState(() {
          percentage = (elapsedDuration.inMilliseconds / totalDuration.inMilliseconds) * 100;
        });
      } else {
        timer.cancel();
        setState(() {
          percentage = 100.0; // Cap at 100% when the end time is reached
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manual Time Progress"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Progress: ${percentage.toStringAsFixed(2)}%",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: percentage / 100, // Convert percentage to value between 0 and 1
              minHeight: 10,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: AlarmProgressExample()));
}
