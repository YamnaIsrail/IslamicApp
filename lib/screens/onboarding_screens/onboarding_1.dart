import 'package:flutter/material.dart';
import 'package:islam_app/screens/onboarding_screens/onboarding_2.dart';
import 'package:islam_app/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';


class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
          Container(
            color: Color(0xff23190d),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(

                    )
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 300,
                    height: double.infinity,
                    child: Image.asset(
                      'assets/rail.png',
                    //  fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
      
          ),

          Column(
              children: [
                SizedBox(height: 25,),
                Text(
                  'Happy Ramadan Kareem',
                  style: GoogleFonts.abhayaLibre(
                    fontSize: 45,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Ramdan is blessings from Allah!',
                  style: GoogleFonts.abhayaLibre(
                  fontSize: 28.0,
                  color: primaryColor,
                  fontWeight: FontWeight.normal,
                ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
      
      
          ],
        ),
      
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder)=>OnBoarding2()));
            },
          splashColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Icon(Icons.arrow_forward),
      ),
      ),
    );
  }
}

