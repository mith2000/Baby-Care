import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/bmi_model.dart';

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

  Stream<List<BmiModel>> createBmi(List<BmiModel> listBMIModel) {
    for (var i = 0; i < listBMIModel.length; i++) {
      DocumentReference documentReferencer =
          firebaseFirestore.collection('bmi').doc();
      documentReferencer
          .set(listBMIModel[i].toJson())
          .whenComplete(() => print("bmi added to the database"))
          .catchError((e) => print(e));
    }
    return firebaseFirestore.collection('bmi').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BmiModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<void> updateBmi(String idBaby, String idBmi, BmiModel bmiModel) {
    DocumentReference documentReferencer =
        firebaseFirestore.collection('bmi').doc(idBmi);
    documentReferencer
        .update(bmiModel.toJson())
        .whenComplete(() => print("BMI updated in the database"))
        .catchError((e) => print(e));
    return firebaseFirestore.collection('bmi').snapshots().map((snapshot) {
      return snapshot.docs.forEach((doc) {
        if (doc['idBaby'] == idBaby) {
          return BmiModel.fromSnapshot(doc);
        }
      });
    });
  }
}
