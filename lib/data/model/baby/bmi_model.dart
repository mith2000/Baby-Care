// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/constants/app_constants.dart';

class BmiModel extends Equatable {
  String id;
  final String idBaby;
  final BMIType type;
  final DateTime updateDate;
  final int value;

  void setId(String id) {
    this.id = id;
  }

  BmiModel({
    this.id,
    this.idBaby,
    this.type,
    this.updateDate,
    this.value,
  });

  static BmiModel fromSnapshot(DocumentSnapshot snap) {
    DateTime myDateTime = snap['updateDate'].toDate();
    BmiModel babyModel = BmiModel(
      id: snap.id,
      idBaby: snap['idBaby'],
      type: snap['type'] == 'Height' ? BMIType.Height : BMIType.Weight,
      updateDate: myDateTime,
      value: snap['value'],
    );
    return babyModel;
  }

  @override
  List<Object> get props => [
        id,
        idBaby,
        type,
        value,
      ];

  Map<String, Object> toJson() {
    Timestamp myTimeStamp = Timestamp.fromDate(updateDate);
    return {
      "id": id,
      "idBaby": idBaby,
      "type": type == BMIType.Height ? 'Height' : 'Weight',
      "updateDate": myTimeStamp,
      "value": value,
    };
  }
}
