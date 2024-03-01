import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islam_app/Api_data/models/quran_api_model.dart';
import 'package:islam_app/Api_data/services/quran_api_services.dart';
import 'package:islam_app/Screens/Quran/surah_page.dart';
import 'package:islam_app/widgets/Colors.dart';


class QuranApi extends StatefulWidget {
  @override
  _QuranApiState createState() => _QuranApiState();
}

class _QuranApiState extends State<QuranApi> {
  final QuranServices _quranService = QuranServices();

 Quran? _quranData; // Nullable Quran object

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the function to fetch data
  }

  // Inside the fetchData() method
  void fetchData() async {
    try {
      Quran quran = await _quranService.fetchQuranData();
      print('API Response: $quran'); // Add this line to print the response
      setState(() {
        _quranData = quran;
      });
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          title: Text('Quran Data'),
          backgroundColor: primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon( Icons.arrow_left_rounded,
              size: 40,),
          ),
        ),
        body: _quranData != null
            ?
        // ... (existing code)

        ListView.builder(
          itemCount: _quranData!.data.surahs.length,
          itemBuilder: (context, index) {
            Surah surah = _quranData!.data.surahs[index];
            return Container(
              //padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8) ,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                title: Text(surah.name),
                titleTextStyle: GoogleFonts.notoNastaliqUrdu(
                  fontSize: 26
                ),
                titleAlignment: ListTileTitleAlignment.center,
                trailing: Text('${index + 1}'),
                leadingAndTrailingTextStyle: TextStyle(
                    fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,

                ),
                subtitle: Text(surah.englishName),
                onTap: () {
                  // Navigate to the SurahPage when a Surah is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahPage(surah: surah),
                    ),
                  );
                },
              ),
            );
          },
        )

      // ... (existing code)

            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}


