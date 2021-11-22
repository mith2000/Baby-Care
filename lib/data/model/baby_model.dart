import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BabyModel extends Equatable {
  final String name;
  final String idAccount;
  final double birth;
  final String image;

  const BabyModel({this.name, this.idAccount, this.birth, this.image});

  static BabyModel fromSnapshot(DocumentSnapshot snap) {
    BabyModel babyModel = BabyModel(
      name: snap['name'],
      idAccount: snap['idAccount'],
      birth: snap['birth'] == null ? snap['birth'] : snap['birth'].toDouble(),
      image: snap['image'],
    );
    return babyModel;
  }

  @override
  List<Object> get props => [
        name,
        idAccount,
        birth,
        image,
      ];
}
