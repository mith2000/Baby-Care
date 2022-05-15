import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://recommendsys-babycare.herokuapp.com/';

class RecommendRepository {
  static final http.Client httpClient = http.Client();

  static Future<String> getSampleStringData() async {
    final response = await httpClient.get(
        new Uri(scheme: 'https', host: 'recommendsys-babycare.herokuapp.com'));
    if (response.statusCode == 200) {
      final welcome = jsonDecode(response.body) as String;
      return welcome ?? '';
    } else {
      throw Exception('Something wrong');
    }
  }
}
