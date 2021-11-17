import 'package:flutter/material.dart';

class SampleModel {
  String sampleRequiredParam;
  String sampleDefaultValueParam;
  SampleModel({
    @required this.sampleRequiredParam,
    this.sampleDefaultValueParam = '',
  });
}
