// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/converter.dart';

class FoodModel extends Equatable {
  String id;
  final FoodType type;
  final String idBaby;
  int countUpdate;
  final DateTime updateDate;
  final double value;

  void setId(String id) {
    this.id = id;
  }

  void setCountUpdate(int count) {
    this.countUpdate = count;
  }

  FoodModel({
    this.id,
    this.type,
    this.idBaby,
    this.countUpdate,
    this.updateDate,
    this.value,
  });

  static FoodModel fromSnapshot(DocumentSnapshot snap) {
    DateTime myDateTime = snap['updateDate'].toDate();
    FoodModel babyModel = FoodModel(
      id: snap['id'],
      type: Converter.stringToFoodType(snap['type']),
      idBaby: snap['idBaby'],
      countUpdate: snap['countUpdate'],
      updateDate: myDateTime,
      value: snap['value'],
    );
    return babyModel;
  }

  @override
  List<Object> get props => [
        id,
        type,
        idBaby,
        countUpdate,
        updateDate,
        value,
      ];

  Map<String, Object> toJson() {
    Timestamp myTimeStamp = Timestamp.fromDate(updateDate);
    return {
      "id": id,
      "type": Converter.foodTypeToString(type),
      "idBaby": idBaby,
      "countUpdate": countUpdate ?? 0,
      "updateDate": myTimeStamp,
      "value": value,
    };
  }
}
