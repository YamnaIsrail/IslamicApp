import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:islam_app/widgets/Colors.dart';



class alarm extends StatefulWidget {
  @override
  State<alarm> createState() => _alarmState();
}

class _alarmState extends State<alarm> {

// creating text ediiting controller to take hour
// and minute as input
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarms'),
        centerTitle: true,
        backgroundColor:  primaryColor,

      ),
      body: Container(

        // color: Color(0xfff5e9da),
        child: Center(
            child: Column(children: <Widget>[
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xffd3e3c4),
                        borderRadius: BorderRadius.circular(11)),
                    child: Center(
                      child: TextField(
                        controller: hourController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xffd3e3c4),
                        borderRadius: BorderRadius.circular(11)),
                    child: Center(
                      child: TextField(
                        controller: minuteController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: TextButton(
                  child: const Text(
                    'Create alarm',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    int hour;
                    int minutes;
                    hour = int.parse(hourController.text);
                    minutes = int.parse(minuteController.text);

                    FlutterAlarmClock.createAlarm(hour: hour,minutes: minutes);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {

                  // show alarm
                  FlutterAlarmClock.showAlarms();
                },
                child: const Text(
                  'Show Alarms',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: TextButton(
                    child: const Text(
                      'Create timer',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      int minutes;
                      minutes = int.parse(minuteController.text);

                      // create timer
                      FlutterAlarmClock.createTimer(length: minutes);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AboutDialog(
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                      //  color: Color(0xff3089b9),
                                        borderRadius: BorderRadius.circular(11)),


                                    child: Text("Timer is set",
                                        style: TextStyle(
                                         // color: Colors.white,
                                            fontSize: 22, fontWeight: FontWeight.bold)),
                                  ),
                                )
                              ],
                            );
                          });
                    }),
              ),
              ElevatedButton(
                onPressed: () {

                  // show timers
                  FlutterAlarmClock.showTimers();
                },
                child: Text(
                  "Show Timers",
                  style: TextStyle(fontSize: 17),
                ),
              )
            ])),
      ),
    );
  }
}
