import 'package:flutter/material.dart';
import 'package:islam_app/Screens/PrayerTimings/services/prayer_time_services.dart';
import 'package:islam_app/widgets/Colors.dart';

class RemainingActivity extends StatefulWidget {
  const RemainingActivity({Key? key}) : super(key: key);

  @override
  State<RemainingActivity> createState() => _RemainingActivityState();
}

class _RemainingActivityState extends State<RemainingActivity> {
  late DateTime nextPrayerTime = DateTime.now(); // Initialize with current time

  late String nextPrayerName = "Upcoming activity";

  @override
  void initState() {
    super.initState();
    // Fetch the prayer times and calculate the next prayer time
    getNextPrayerTime().then((value) {
      nextPrayerTime = value;
      nextPrayerName = getPrayerName(nextPrayerTime);
      setState(() {}); // Update the UI after getting the next prayer time
    });
  }


  @override
  Widget build(BuildContext context) {
    // Calculate the remaining time until the next prayer
    Duration remainingTime = nextPrayerTime.difference(DateTime.now());
    String remainingTimeString = '${remainingTime.inHours}h ${remainingTime.inMinutes.remainder(60)}min';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$nextPrayerName',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Remaining Activity",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(value: true, onChanged: (onChanged) {}),
              SizedBox(height: 5),
              Text(
                remainingTimeString,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }



}




final prayerTimesService = PrayerTimesService();


Future<DateTime> getNextPrayerTime() async{
  await prayerTimesService.fetchPrayerTimes();

  DateTime now = DateTime.now();
  List<DateTime> prayerTimes = [prayerTimesService.fajar, prayerTimesService.sunrise, prayerTimesService.dhuhr, prayerTimesService.asar, prayerTimesService.maghrib, prayerTimesService.isha];
  prayerTimes.sort((a, b) => a.compareTo(b));

  for (DateTime prayerTime in prayerTimes) {
    if (prayerTime.isAfter(now)) {
      return prayerTime;
    }
  }

  // If all prayer times are in the past, return the first prayer time of the next day
  return prayerTimes.first.add(Duration(days: 1));
}


String getPrayerName(DateTime time) {
  if (time == prayerTimesService.fajar) {
    return 'Fajr';
  } else if (time == prayerTimesService.sunrise) {
    return 'Sunrise';
  } else if (time == prayerTimesService.dhuhr) {
    return 'Dhuhr';
  } else if (time == prayerTimesService.asar) {
    return 'Asar';
  } else if (time == prayerTimesService.maghrib) {
    return 'Maghrib';
  } else if (time == prayerTimesService.isha) {
    return 'Isha';
  }
  return '';
}