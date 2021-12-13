import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';
import 'package:flutter_babycare/data/source/ni_repository.dart';
import 'package:flutter_babycare/utils/converter.dart';
import 'package:uuid/uuid.dart';

class FoodRepository {
  final FirebaseFirestore firebaseFirestore;
  final NIRepository niRepository;

  FoodRepository(
      {FirebaseFirestore firebaseFirestore, NIRepository niRepository})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance,
        this.niRepository = niRepository ?? new NIRepository();

  Future<String> createFood(List<FoodModel> listFoodModel) async {
    for (var i = 0; i < listFoodModel.length; i++) {
      String idFood = Uuid().v4();
      listFoodModel[i].setId(idFood);
      DocumentReference documentReferencer =
          firebaseFirestore.collection('food').doc(idFood);
      String temp = listFoodModel[i].type.toString();
      await documentReferencer
          .set(listFoodModel[i].toJson())
          .whenComplete(() => print("$temp food added to the database"))
          .catchError((e) => print(e));

      List<NIModel> listNi = Converter.foodToNI(listFoodModel[i]);

      for (var j = 0; j < listNi.length; j++) {
        await niRepository.createNi(listNi[j], listFoodModel[0].idBaby);
      }
    }
    return listFoodModel[0].idBaby;
  }

  Future<String> updateFood(
      {List<FoodModel> listFoodModel, String idBaby}) async {
    for (var i = 0; i < listFoodModel.length; i++) {
      DocumentReference documentReferencer =
      firebaseFirestore.collection('food').doc(listFoodModel[i].id);
      documentReferencer
          .update(listFoodModel[i].toJson())
          .whenComplete(() => print("Food updated in the database"))
          .catchError((e) => print(e));

      List<NIModel> listNi = Converter.foodToNI(listFoodModel[i]);

      for (var j = 0; j < listNi.length; j++) {
        await niRepository.createNi(listNi[j], listFoodModel[0].idBaby);
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
