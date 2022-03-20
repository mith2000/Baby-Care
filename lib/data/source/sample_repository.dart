import 'package:flutter/material.dart';
import 'package:flutter_babycare/data/api/sample_api_provider.dart';
import 'package:flutter_babycare/data/model/sample_model.dart';

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
