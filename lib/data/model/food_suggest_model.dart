import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/converter.dart';

class Food_Suggest_Model extends Equatable {
  final String id;
  final String idBaby;
  final FoodType type;
  final double value;
  final DateTime date;

  Food_Suggest_Model({
    this.id,
    this.idBaby,
    this.type,
    this.value,
    this.date,
  });

  static Food_Suggest_Model fromSnapshot(DocumentSnapshot snap) {
    DateTime myDateTime = snap['date'].toDate();
    Food_Suggest_Model babyModel = Food_Suggest_Model(
      id: snap['id'],
      idBaby: snap['idBaby'],
      type: Converter.stringToFoodType(snap['type']),
      value: snap['value'],
      date: myDateTime,
    );
    return babyModel;
  }

  @override
  List<Object> get props => [id, idBaby, type, value, date];

  Map<String, Object> toJson() {
    Timestamp myTimeStamp = Timestamp.fromDate(date);
    return {
      "id": id,
      "idBaby": idBaby,
      "type": Converter.foodTypeToString(type),
      "value": value,
      "date": myTimeStamp,
    };
  }
}
