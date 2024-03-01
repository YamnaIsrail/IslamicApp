import 'package:islam_app/Screens/PrayerTimings/services/prayer_time_services.dart';

Future<void> setAlarms(PrayerTimesService prayerTimesService) async {
  await setAlarms(prayerTimesService.fajar as PrayerTimesService);
  await setAlarms(prayerTimesService.sunrise as PrayerTimesService);
  await setAlarms(prayerTimesService.dhuhr as PrayerTimesService);
  await setAlarms(prayerTimesService.asar as PrayerTimesService);
  await setAlarms(prayerTimesService.maghrib as PrayerTimesService);
  await setAlarms(prayerTimesService.isha as PrayerTimesService);
}
