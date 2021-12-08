import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/converter.dart';

class NIModel extends Equatable {
  final String id;
  final NIType type;
  final String idFood;
  final DateTime updateDate;
  final double value;

  NIModel({
    this.id,
    this.type,
    this.idFood,
    this.updateDate,
    this.value,
  });

  static NIModel fromSnapshot(DocumentSnapshot snap) {
    DateTime myDateTime = snap['updateDate'].toDate();
    NIModel babyModel = NIModel(
      id: snap.id,
      type: Converter.stringToNIType(snap['type']),
      idFood: snap['idFood'],
      updateDate: myDateTime,
      value: snap['value'],
    );
    return babyModel;
  }

  @override
  List<Object> get props => [
        id,
        type,
        idFood,
        updateDate,
        value,
      ];

  Map<String, Object> toJson() {
    Timestamp myTimeStamp = Timestamp.fromDate(updateDate);
    return {
      "id": id,
      "type": Converter.niTypeToString(type),
      "idFood": idFood,
      "updateDate": myTimeStamp,
      "value": value,
    };
  }
}
