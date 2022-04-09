import 'package:flutter/material.dart';
import '../model/sample_model.dart';
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
