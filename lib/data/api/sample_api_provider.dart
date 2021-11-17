import 'package:flutter/material.dart';
import 'package:flutter_babycare/data/model/sample_model.dart';
import 'package:http/http.dart' as http;

class SampleApiProvider {
  static Future<SampleModel> getSampleModel(
      {@required sampleRequiredParam}) async {
    return SampleModel(
      sampleRequiredParam: sampleRequiredParam,
      sampleDefaultValueParam: '',
    );
  }
}
