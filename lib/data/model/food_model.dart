import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/converter.dart';

class FoodModel extends Equatable {
  String id;
  final FoodType type;
  final String idBaby;
  final DateTime updateDate;
  final double value;

  void setId(String id) {
    this.id = id;
  }

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
      type: Converter.stringToFoodType(snap['type']),
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
      "type": Converter.foodTypeToString(type),
      "idBaby": idBaby,
      "updateDate": myTimeStamp,
      "value": value,
    };
  }
}
