import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islam_app/Screens/PrayerTimings/custom_list_tile.dart';
import 'package:islam_app/Screens/PrayerTimings/prayer_drawer.dart';
import 'package:islam_app/Screens/PrayerTimings/services/prayer_time_services.dart';
import 'package:islam_app/widgets/Colors.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({Key? key}) : super(key: key);

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  final prayerTimesService = PrayerTimesService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPrayerTimes();
  }

  Future<void> loadPrayerTimes() async {
    try {
      await prayerTimesService.fetchPrayerTimes();
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      // Handle error, show error message or retry option
      print('Error loading prayer times: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text('Prayer Times'),
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.menu),
        //     onPressed: () {
        //       Scaffold.of(context).openEndDrawer();
        //     },
        //   ),
        // ],
      ),
      endDrawer: PrayerDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : Padding(
              padding: const EdgeInsets.all(40.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  CustomListTile(
                    title: 'Fajr',
                    tileColor: primaryColor,
                    trailing:
                        DateFormat('hh:mm a').format(prayerTimesService.fajar),
                  ),
                  SizedBox(height: 30),
                  CustomListTile(
                    title: 'Sunrise',
                    tileColor: primaryColor,
                    trailing: DateFormat('hh:mm a')
                        .format(prayerTimesService.sunrise),
                  ),
                  SizedBox(height: 30),
                  CustomListTile(
                    title: 'Dhuhr',
                    tileColor: primaryColor,
                    trailing:
                        DateFormat('hh:mm a').format(prayerTimesService.dhuhr),
                  ),
                  SizedBox(height: 30),
                  CustomListTile(
                    title: 'Asr',
                    tileColor: primaryColor,
                    trailing:
                        DateFormat('hh:mm a').format(prayerTimesService.asar),
                  ),
                  SizedBox(height: 30),
                  CustomListTile(
                    title: 'Maghrib',
                    tileColor: primaryColor,
                    trailing: DateFormat('hh:mm a')
                        .format(prayerTimesService.maghrib),
                  ),
                  SizedBox(height: 30),
                  CustomListTile(
                    title: 'Isha',
                    tileColor: primaryColor,
                    trailing:
                        DateFormat('hh:mm a').format(prayerTimesService.isha),
                  ),
                ],
              ),
            ),
    );
  }
}
