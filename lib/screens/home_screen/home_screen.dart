import 'package:flutter/material.dart';
import 'package:islam_app/Screens/Home_Screen/Home_screen_components/DailySupplication.dart';
import 'package:islam_app/Screens/Home_Screen/Home_screen_components/remaining_activity.dart';
import 'package:islam_app/Screens/Quran/fetch_api.dart';
import 'package:islam_app/Screens/PrayerTimings/prayer_timings.dart';
import 'package:islam_app/widgets/footer.dart';
import 'package:islam_app/widgets/Colors.dart';
import '../Dua/dua_page.dart';
import 'Home_screen_components/sehar_iftar_card.dart';
import 'Home_screen_components/greetings.dart';
import 'Home_screen_components/icon_cards.dart';
import 'package:islam_app/Screens/PrayerTimings/services/prayer_time_services.dart';

PrayerTimesService prayerService = PrayerTimesService();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String seharTime;
  late String iftarTime;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initializePrayerTimes();
  }

  Future<void> initializePrayerTimes() async {
    try {
      await prayerService.fetchPrayerTimes();
      setState(() {
        int seharHour = prayerService.fajar.hour - 2;
        int seharMin = prayerService.fajar.minute;
        int iftarHour = prayerService.maghrib.hour;
        int iftarMin = prayerService.maghrib.minute;

        seharTime = '$seharHour : ${seharMin.toString().padLeft(2, '0')}';
        iftarTime = '$iftarHour : ${iftarMin.toString().padLeft(2, '0')}';
        _isLoading = false; // Prayer times loaded, set isLoading to false
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
      body: SafeArea(
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(), // Show loading indicator
        )
            : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                greetings(),
                SizedBox(height: 10),
                RemainingActivity(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      children: [
                        MyCard(
                          time: seharTime,
                          title: "Sahar",
                        ),
                        MyCard(
                          time: iftarTime,
                          title: "Iftar",
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      color: primaryColor,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.wb_twilight, size: 30),
                              SizedBox(width: 30),
                              Switch(
                                  value: true, onChanged: (onChanged) {}),
                            ],
                          ),
                          Text(
                            "Daily Remainders",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Container(
                            color: Color(0xffd7b889),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Supplication of the day'),
                                Text('Fajar timings Alarm'),
                                Text('Sehar time'),
                                //Text('data'),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                    // PrayerTimes()
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                DailyDuasCard(
                  duaTitle: 'Dua for a Blessed Day',
                  duaText:
                  'O Allah, bless this day and guide me in my actions.',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconCards(
                      myicon: Icons.timer_outlined,
                      title: "Prayer Time",
                      fn: () => PrayerTimesPage(),
                    ),
                    IconCards(
                      myicon: Icons.my_library_books_outlined,
                      title: "Al Quran",
                      fn: () => QuranApi(),
                    ),
                    IconCards(
                      myicon: Icons.mosque,
                      title: "Daily Duas",
                      fn: () => DuaPage(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [myFooter()],
    );
  }
}
