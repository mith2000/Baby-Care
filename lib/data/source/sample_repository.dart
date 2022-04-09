import 'package:flutter/material.dart';
import '../api/sample_api_provider.dart';
import '../model/sample_model.dart';

class SampleRepository {
  Future<SampleModel> getSampleModel({@required sampleRequiredParam}) async {
    var model = await SampleApiProvider.getSampleModel(
        sampleRequiredParam: sampleRequiredParam);
    if (model != null) {
      return model;
    } else
      return null;
  }
}
