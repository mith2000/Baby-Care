import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_babycare/data/model/sample_model.dart';
import 'package:http/http.dart' as http;

class ApiSource {
  static String domain = '';
  static String getAPI = '';

  static Future<SampleModel> getSampleModel(
      {@required sampleRequiredParam}) async {
    // var client = http.Client();
    var _model = null;

    try {
      // var response = await client.post(getAPI)
      var response = await http.get(Uri.https(domain, 'page'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        //object with fromJson()
        _model = SampleModel(
          sampleRequiredParam: sampleRequiredParam,
          sampleDefaultValueParam: '',
        );
      }
    } catch (Exception) {
      return _model;
    }

    return _model;
  }
}
