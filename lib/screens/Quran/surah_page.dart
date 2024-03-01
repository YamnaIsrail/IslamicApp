import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islam_app/Api_data/models/quran_api_model.dart';
import 'package:islam_app/widgets/Colors.dart'; // Import your Quran model

class SurahPage extends StatelessWidget {
  final Surah surah;

  SurahPage({required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text(surah.name),
        backgroundColor: secondaryColor,
      ),
      body: ListView.builder(
        itemCount: surah.ayahs.length,
        itemBuilder: (context, index) {
          Ayah ayah = surah.ayahs[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20)
            ),
            child: ListTile(
              title: Text('Ayah ${ayah.numberInSurah}'),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
              subtitleTextStyle: GoogleFonts.notoNastaliqUrdu(
                  fontSize: 26
              ),

              subtitle: Directionality(
                textDirection: TextDirection.rtl, // Set text direction to rtl
                child: Text(
                  ayah.text,
                  style: GoogleFonts.amiri(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
              ),
              // Add more widgets to display other properties if needed
            ),
          );
        },
      ),
    );
  }
}
