import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:islam_app/Screens/Home_Screen/Home_Screen.dart';
import 'package:islam_app/Screens/alarm/sehar_iftar_alarm.dart';
import 'package:islam_app/widgets/Colors.dart';

class MyCard extends StatefulWidget {
  final String time;
  final String title;

  MyCard({required this.time, required this.title});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool switchValue = false;
  late DateTime iftarTime;
  late DateTime saharTime;


  @override
  void initState() {
    super.initState();
    initializePrayerTimes();
  }

  Future<void> initializePrayerTimes() async {
    await prayerService.fetchPrayerTimes();
    setState(() {
      iftarTime = prayerService.maghrib;
      saharTime = prayerService.fajar.subtract(Duration(hours: 2));

       });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.wb_twilight, size: 30),
                SizedBox(width: 10),
                Switch(
                  value: switchValue,
                  onChanged: (bool value) async {
                    setState(() {
                      switchValue = value;
                    });
                    print("alarm print here");

                    if (value) {
                      if (widget.title == "Sahar") {
                         saharAlarm();
                      } else {
                         iftarAlarm();
                      }
                    } else {
                      FlutterAlarmClock.showAlarms();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              "${widget.time}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "${widget.title} Time",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 20),
                ImageIcon(
                  AssetImage("assets/icon2_iftar.png"),
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
