import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'dua_model.dart';

class Repository {
  final quranBaseUrl = 'https://apimuslimify.vercel.app/api/v2';
  final shalahBaseUrl = 'https://api.myquran.com/v1';
  final videoBaseUrl = 'www.googleapis.com';


  Future<List<Dua>> getDuaList() async {
    final response = await http.get(Uri.parse('$quranBaseUrl/doaharian'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Dua> duaList = [];
        for (var item in data['data']) {
          duaList.add(Dua.fromJson(item));
        }
        return duaList;
      } else {
        throw Exception('Failed to load dua list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  // Future<List<LocationModel>> postLocationList({required String city}) async {
  //   final response =
  //   await http.get(Uri.parse('$shalahBaseUrl/sholat/kota/cari/$city'));
  //
  //   try {
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       final List<LocationModel> locationList = [];
  //       for (var item in data['data']) {
  //         locationList.add(LocationModel.fromJson(item));
  //       }
  //       return locationList;
  //     } else {
  //       throw Exception('Failed to load location list');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }


}