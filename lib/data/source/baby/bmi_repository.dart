import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/bmi_model.dart';
import 'package:uuid/uuid.dart';

class BmiRepository {
  static Future<List<BmiModel>> fetchBmi(String idBaby) async {
    List<BmiModel> list;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bmi')
          .where('idBaby', isEqualTo: idBaby)
          .get();
      list = snapshot.docs.map((doc) => BmiModel.fromSnapshot(doc)).toList();
    } catch (error) {
      print(error);
      return null;
    }
    return list;
  }

  static Future<String> createBmi(List<BmiModel> listBMIModel) async {
    String idBaby = listBMIModel[0].idBaby;
    for (var i = 0; i < listBMIModel.length; i++) {
      String idBMI = Uuid().v4();
      listBMIModel[i].setId(idBMI);
      DocumentReference documentReferencer =
          FirebaseFirestore.instance.collection('bmi').doc(idBMI);
      documentReferencer
          .set(listBMIModel[i].toJson())
          .whenComplete(() => print("bmi added to the database"))
          .catchError((e) => print(e));
    }
    return idBaby;
  }

  static Future<String> updateBMI(
      {List<BmiModel> listBMIModel, String idBaby}) async {
    for (var i = 0; i < listBMIModel.length; i++) {
      DocumentReference documentReferencer = await FirebaseFirestore.instance
          .collection('bmi')
          .doc(listBMIModel[i].id);
      documentReferencer
          .update(listBMIModel[i].toJson())
          .whenComplete(() => print("BMI updated in the database"))
          .catchError((e) => print(e));
    }
    return idBaby;
  }
}
