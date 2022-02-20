import 'package:flutter/material.dart';
import 'package:flutter_babycare/data/api/api_source.dart';
import 'package:flutter_babycare/data/model/sample_model.dart';

class SampleRepository {
  Future<SampleModel> getSampleModel({@required sampleRequiredParam}) async {
    var model = await ApiSource.getSampleModel(
        sampleRequiredParam: sampleRequiredParam);
    if (model != null) {
      return model;
    } else
      return null;
  }
}
