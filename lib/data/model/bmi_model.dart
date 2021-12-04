import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BmiModel extends Equatable {
  final String id;
  final String idBaby;
  final String type;
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
      type: snap['type'],
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
      "type": type,
      "value": value,
    };
  }
}
