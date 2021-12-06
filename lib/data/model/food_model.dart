
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/converter.dart';

class FoodModel extends Equatable {
  final String id;
  final NIType type;
  final String idBaby;
  final DateTime updateDate;
  final double value;

  FoodModel({
    this.id,
    this.type,
    this.idBaby,
    this.updateDate,
    this.value,
  });

  static FoodModel fromSnapshot(DocumentSnapshot snap) {
    DateTime myDateTime = snap['updateDate'].toDate();
    FoodModel babyModel = FoodModel(
      id: snap.id,
      type: Converter.stringToNIType(snap['type']),
      idBaby: snap['idBaby'],
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
    updateDate,
    value,
  ];

  Map<String, Object> toJson() {
    Timestamp myTimeStamp = Timestamp.fromDate(updateDate);
    return {
      "id": id,
      "type": Converter.niTypeToString(type),
      "idBaby": idBaby,
      "updateDate": myTimeStamp,
      "value": value,
    };
  }
}
