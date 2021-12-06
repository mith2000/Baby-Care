import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/constants/app_constants.dart';

class BmiModel extends Equatable {
  final String id;
  final String idBaby;
  final BMIType type;
  final int value;

  BmiModel({
    this.id,
    this.idBaby,
    this.type,
    this.value,
  });

  static BmiModel fromSnapshot(DocumentSnapshot snap) {
    BmiModel babyModel = BmiModel(
      id: snap.id,
      idBaby: snap['idBaby'],
      type: snap['type'] == 'Height' ? BMIType.Height: BMIType.Weight,
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
    return {
      "id": id,
      "idBaby": idBaby,
      "type": type == BMIType.Height ? 'Height' : 'Weight',
      "value": value,
    };
  }
}
