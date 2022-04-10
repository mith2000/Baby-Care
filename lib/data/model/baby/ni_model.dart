import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../../../constants/app_constants.dart';
import '../../../../utils/converter.dart';

class NIModel extends Equatable {
  String id;
  final NIType type;
  final String idBaby;
  final DateTime updateDate;
  final double value;

  void setID(String id) {
    this.id = id;
  }

  NIModel({
    this.id,
    this.type,
    this.idBaby,
    this.updateDate,
    this.value,
  });

  static NIModel fromSnapshot(DocumentSnapshot snap) {
    DateTime myDateTime = snap['updateDate'].toDate();
    NIModel babyModel = NIModel(
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
      'id': id,
      'type': Converter.niTypeToString(type),
      'idBaby': idBaby,
      'updateDate': myTimeStamp,
      'value': value,
    };
  }
}
