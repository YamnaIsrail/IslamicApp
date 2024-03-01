import 'package:flutter/material.dart';
import 'package:islam_app/Screens/Home_Screen/Home_screen_components/remaining_activity.dart';
import 'package:islam_app/widgets/Colors.dart';
import 'package:timezone/timezone.dart' as tz;

class PrayerDrawer extends StatefulWidget {
  const PrayerDrawer({Key? key}) : super(key: key);

  @override
  State<PrayerDrawer> createState() => _PrayerDrawerState();
}

class _PrayerDrawerState extends State<PrayerDrawer> {
  String? selectedTimeZone;

  @override
  void initState() {
    super.initState();
    initializeTimeZone();
  }

  Future<void> initializeTimeZone() async {
    // Initialize selectedTimeZone with a default value
    selectedTimeZone = await getTimeZoneName(null);
  }

  Future<void> _handleTimeZoneSelection(String timezone) async {
    setState(() {
      selectedTimeZone = timezone;
    });
    await prayerTimesService.fetchPrayerTimes(selectedTimeZone: selectedTimeZone);
    // Do something with the selected timezone
    print('Selected timezone: $selectedTimeZone');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Text(
              'Prayer App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            // tileColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.white),
            onTap: () async {
              String? timezone = await TimeZoneSelector.selectTimeZone(context);
              if (timezone != null) {
                _handleTimeZoneSelection(timezone);
              }
            },
            title: Text(selectedTimeZone ?? 'Select Timezone'),
          ),
        ],
      ),
    );
  }
}

class TimeZoneSelector {
  static Future<String?> selectTimeZone(BuildContext context) async {
    // Fetch the list of timezones
    List<String> timezones = tz.timeZoneDatabase.locations.keys.toList();

    // Show a dialog to let the user select the timezone
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Timezone'),
          content: SingleChildScrollView(
            child: ListBody(
              children: timezones
                  .map((timezone) => ListTile(
                title: Text(timezone),
                onTap: () {
                  // Get the selected timezone and pop the dialog
                  Navigator.of(context).pop(timezone);
                },
              ))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

Future<String> getTimeZoneName(String? selectedTimeZone) async {
  return selectedTimeZone ?? 'Asia/Karachi'; // Default timezone
}
