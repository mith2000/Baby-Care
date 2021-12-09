import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';
import 'package:flutter_babycare/utils/converter.dart';
import 'package:uuid/uuid.dart';

class FoodRepository {
  final FirebaseFirestore firebaseFirestore;

  FoodRepository({FirebaseFirestore firebaseFirestore})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance;

  Future<String> createFood(List<FoodModel> listFoodModel) async {
    for (var i = 0; i < listFoodModel.length; i++) {
      String idFood = Uuid().v4();
      listFoodModel[i].setId(idFood);
      DocumentReference documentReferencer =
          firebaseFirestore.collection('food').doc(idFood);
      String temp = listFoodModel[i].type.toString();
      documentReferencer
          .set(listFoodModel[i].toJson())
          .whenComplete(() => print("$temp food added to the database"))
          .catchError((e) => print(e));

      List<NIModel> listNi = Converter.foodToNI(listFoodModel[i]);

      for (var j = 0; j < listNi.length; j++) {
        bool isVariable = false;
        String type = Converter.niTypeToString(listNi[j].type);
        DocumentReference docRef;
        firebaseFirestore
            .collection('ni')
            .where('idBaby', isEqualTo: listFoodModel[0].idBaby)
            .where('type', isEqualTo: type)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            isVariable = true;
            var batch = FirebaseFirestore.instance.batch();
            Map<String, dynamic> data = doc.data();
            docRef = firebaseFirestore.collection('ni').doc(doc.id);
            batch.update(docRef, {'value': data['value'] + listNi[j].value});
            batch.commit().then((a) {
              print('updated $type food');
            });
          });
        }).catchError((error) {
          print(error);
        });
        if (!isVariable) {
          String idNI = Uuid().v4();
          listNi[j].setID(idNI);
          DocumentReference documentReferencer =
              firebaseFirestore.collection('ni').doc(idNI);
          String temp = listNi[j].type.toString();
          documentReferencer
              .set(listNi[j].toJson())
              .whenComplete(() => print("$temp ni added to the database"))
              .catchError((e) => print(e));
        }
      }
    }
    return listFoodModel[0].idBaby;
  }

  Stream<List<FoodModel>> fetchFood(String idBaby) {
    return firebaseFirestore
        .collection('food')
        .where('idBaby', isEqualTo: idBaby)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => FoodModel.fromSnapshot(doc)).toList();
    });
  }
}
