import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/bmi_model.dart';
import 'package:uuid/uuid.dart';

class BmiRepository {
  final FirebaseFirestore firebaseFirestore;

  BmiRepository({FirebaseFirestore firebaseFirestore})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<BmiModel>> fetchBmi(String idBaby) {
    return firebaseFirestore
        .collection('bmi')
        .where('idBaby', isEqualTo: idBaby)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => BmiModel.fromSnapshot(doc)).toList();
    });
  }

  Future<String> createBmi(List<BmiModel> listBMIModel) async {
    String temp = listBMIModel[0].idBaby;
    for (var i = 0; i < listBMIModel.length; i++) {
      String idBMI = Uuid().v4();
      listBMIModel[i].setId(idBMI);
      DocumentReference documentReferencer =
          firebaseFirestore.collection('bmi').doc(idBMI);
      documentReferencer
          .set(listBMIModel[i].toJson())
          .whenComplete(() => print("bmi added to the database"))
          .catchError((e) => print(e));
    }
    return temp;
  }

  Stream<List<BmiModel>> updateBMI(
      {List<BmiModel> listBMIModel, String idBaby}) {
    for (var i = 0; i < listBMIModel.length; i++) {
      DocumentReference documentReferencer =
          firebaseFirestore.collection('bmi').doc(listBMIModel[i].id);
      documentReferencer
          .update(listBMIModel[i].toJson())
          .whenComplete(() => print("BMI updated in the database"))
          .catchError((e) => print(e));
    }
    return firebaseFirestore
        .collection('bmi')
        .where('idBaby', isEqualTo: idBaby)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => BmiModel.fromSnapshot(doc)).toList();
    });
  }
}
