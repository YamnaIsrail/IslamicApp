import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'location_services.dart'; // Importing the LocationService class

class PrayerTimesService {
  late DateTime fajar;
  late DateTime sunrise;
  late DateTime dhuhr;
  late DateTime asar;
  late DateTime maghrib;
  late DateTime isha;

  Future<void> fetchPrayerTimes({String? selectedTimeZone}) async {
    selectedTimeZone ??= 'Asia/Karachi';
    print(selectedTimeZone);
    tz.initializeTimeZones();
    try {
      // Fetch current location dynamically
      final locationService = LocationService();
      final coordinates = await locationService.getCurrentLocation();

      // Create date object with fetched timezone
      final location = tz.getLocation(selectedTimeZone);
      DateTime date = tz.TZDateTime.from(DateTime.now(), location);

      // Fetch prayer times using dynamic coordinates
      CalculationParameters params = CalculationMethod.MuslimWorldLeague();
      params.madhab = Madhab.Hanafi;
      PrayerTimes prayerTimes =
      PrayerTimes(coordinates, date, params, precision: true);

      // Assign prayer times
      fajar = tz.TZDateTime.from(prayerTimes.fajr!, location);
      sunrise = tz.TZDateTime.from(prayerTimes.sunrise!, location);
      dhuhr = tz.TZDateTime.from(prayerTimes.dhuhr!, location);
      asar = tz.TZDateTime.from(prayerTimes.asr!, location);
      maghrib = tz.TZDateTime.from(prayerTimes.maghrib!, location);
      isha = tz.TZDateTime.from(prayerTimes.isha!, location);
    } catch (e) {
      print('Error fetching prayer times: $e');
      // Set default values or handle the error as needed
      fajar = DateTime.now();
      sunrise = DateTime.now();
      dhuhr = DateTime.now();
      asar = DateTime.now();
      maghrib = DateTime.now();
      isha = DateTime.now();
    }
  }
}


