import 'package:flutter/material.dart';
import 'package:islam_app/Screens/Dua/repository.dart';
import 'package:islam_app/widgets/Colors.dart';
import 'package:http/http.dart' as http;
import 'dua_model.dart';
import 'package:translator/translator.dart';

final translator = GoogleTranslator();

// Function to translate Latin to English
Future<String> translateLatinToEnglish(String latin) async {
  try {
    // Translate Latin to English
    var translation = await translator.translate(latin, to: 'en');
    return translation.text ?? latin;
  } catch (e) {
    print('Error translating text: $e');
    return latin;
  }
}

class DuaPage extends StatefulWidget {
  const DuaPage({Key? key}) : super(key: key);
  static const routeName = '/dua-page';

  @override
  State<DuaPage> createState() => _DuaPageState();
}

class _DuaPageState extends State<DuaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_left_rounded,
            size: 40,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Daily Dua',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<List<Dua>>(
        // Explicitly specify the type parameter
          future: Repository().getDuaList() as Future<List<Dua>>?,
          builder: (context, AsyncSnapshot<List<Dua>> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No data available',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return FutureBuilder<String>(
                    future: translateLatinToEnglish(data.name),
                    builder: (context, nameSnapshot) {
                      if (nameSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator(color: primaryColor);
                      } else if (nameSnapshot.hasError) {
                        return Text(
                            'Error translating name: ${nameSnapshot.error}');
                      } else {
                        final translatedName = nameSnapshot.data!;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translatedName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  data.arabic,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  data.latin,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: secondaryColor,
                                  ),
                                ),
                                SizedBox(height: 10),
                                FutureBuilder<String>(
                                  future:
                                      translateLatinToEnglish(data.translation),
                                  builder: (context, translationSnapshot) {
                                    if (translationSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                          color: primaryColor);
                                    } else if (translationSnapshot.hasError) {
                                      return Text(
                                          'Error translating translation: ${translationSnapshot.error}');
                                    } else {
                                      final translatedTranslation =
                                          translationSnapshot.data!;
                                      return Text(
                                        translatedTranslation,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: secondaryColor,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
