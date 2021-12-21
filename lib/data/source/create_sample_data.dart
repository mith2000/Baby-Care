import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';
import 'package:flutter_babycare/utils/converter.dart';

import 'ni_repository.dart';

class CreateSampleData {
  NIRepository niRepository;
  CreateSampleData({NIRepository niRepository})
      : this.niRepository = niRepository ?? new NIRepository();

  Future<void> create() async {
    List<FoodModel> foodList4 = [];
    List<int> foodValues4 = [];
    foodValues4.add(500); //porridge
    foodValues4.add(600); //milk
    foodValues4.add(300); //meat
    foodValues4.add(300); //fish
    foodValues4.add(3); //egg
    foodValues4.add(300); //green_vegets
    foodValues4.add(300); //red_vegets
    foodValues4.add(300); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList4.add(FoodModel(
        idBaby: "0cd64145-113c-41c3-b867-fa11d032b632",
        type: FoodType.values[i],
        countUpdate: 4,
        value: foodValues4[i].toDouble(),
        updateDate: DateTime(2021, 12, 15),
      ));
    }

    List<FoodModel> foodList3 = [];
    List<int> foodValues3 = [];
    foodValues3.add(500); //porridge
    foodValues3.add(600); //milk
    foodValues3.add(300); //meat
    foodValues3.add(300); //fish
    foodValues3.add(3); //egg
    foodValues3.add(300); //green_vegets
    foodValues3.add(300); //red_vegets
    foodValues3.add(300); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList3.add(FoodModel(
        idBaby: "0cd64145-113c-41c3-b867-fa11d032b632",
        type: FoodType.values[i],
        countUpdate: 3,
        value: foodValues3[i].toDouble(),
        updateDate: DateTime(2021, 12, 16),
      ));
    }

    List<FoodModel> foodList2 = [];
    List<int> foodValues2 = [];
    foodValues2.add(500); //porridge
    foodValues2.add(600); //milk
    foodValues2.add(300); //meat
    foodValues2.add(300); //fish
    foodValues2.add(3); //egg
    foodValues2.add(300); //green_vegets
    foodValues2.add(300); //red_vegets
    foodValues2.add(300); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList2.add(FoodModel(
        idBaby: "0cd64145-113c-41c3-b867-fa11d032b632",
        type: FoodType.values[i],
        countUpdate: 2,
        value: foodValues2[i].toDouble(),
        updateDate: DateTime(2021, 12, 17),
      ));
    }

    List<FoodModel> foodList1 = [];
    List<int> foodValues1 = [];
    foodValues1.add(500); //porridge
    foodValues1.add(600); //milk
    foodValues1.add(300); //meat
    foodValues1.add(300); //fish
    foodValues1.add(3); //egg
    foodValues1.add(300); //green_vegets
    foodValues1.add(300); //red_vegets
    foodValues1.add(300); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList1.add(FoodModel(
        idBaby: "0cd64145-113c-41c3-b867-fa11d032b632",
        type: FoodType.values[i],
        countUpdate: 1,
        value: foodValues1[i].toDouble(),
        updateDate: DateTime(2021, 12, 19),
      ));
    }

    List<FoodModel> foodList0 = [];
    List<int> foodValues0 = [];
    foodValues0.add(500); //porridge
    foodValues0.add(600); //milk
    foodValues0.add(300); //meat
    foodValues0.add(300); //fish
    foodValues0.add(3); //egg
    foodValues0.add(300); //green_vegets
    foodValues0.add(300); //red_vegets
    foodValues0.add(300); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList0.add(FoodModel(
        idBaby: "0cd64145-113c-41c3-b867-fa11d032b632",
        type: FoodType.values[i],
        countUpdate: 0,
        value: foodValues0[i].toDouble(),
        updateDate: DateTime(2021, 12, 21),
      ));
    }

    List<FoodModel> list = [];

    for (var i = 0; i < FoodType.values.length; i++) {
      list.add(foodList0[i]);
      list.add(foodList4[i]);
      list.add(foodList3[i]);
      list.add(foodList2[i]);
      list.add(foodList1[i]);
    }

    for (var i = 0; i < list.length; i++) {
      String idFood = Uuid().v4();
      list[i].setId(idFood);
      DocumentReference documentReferencer =
          FirebaseFirestore.instance.collection('food').doc(idFood);
      String temp = list[i].type.toString();
      await documentReferencer
          .set(list[i].toJson())
          .whenComplete(() => print("$temp food added to the database"))
          .catchError((e) => print(e));

      List<NIModel> listNi = Converter.foodToNI(list[i]);

      for (var j = 0; j < listNi.length; j++) {
        await niRepository.createNi(listNi[j], list[0].idBaby);
      }
    }
  }
}
