import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/source/baby/food_repository.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_constants.dart';
import '../model/baby/food_model.dart';
import '../model/baby/ni_model.dart';
import '../../utils/converter.dart';

import 'baby/ni_repository.dart';

class CreateSampleData {
  CreateSampleData();

  static Future<String> create() async {
    //List<FoodModel> foodList4 = [];
    String idBaby = "d4f1d35b-ae49-4a6e-a269-1793812239b7";
    // List<int> foodValues4 = [];
    // foodValues4.add(500); //porridge
    // foodValues4.add(600); //milk
    // foodValues4.add(0); //meat
    // foodValues4.add(0); //fish
    // foodValues4.add(1); //egg
    // foodValues4.add(100); //green_vegets
    // foodValues4.add(50); //red_vegets
    // foodValues4.add(60); //citrus_fruit
    // for (var i = 0; i < FoodType.values.length; i++) {
    //   foodList4.add(FoodModel(
    //     idBaby: idBaby,
    //     type: FoodType.values[i],
    //     value: foodValues4[i].toDouble(),
    //     updateDate: DateTime(2021, 12, 25),
    //   ));
    // }

    // List<FoodModel> foodList3 = [];
    // List<int> foodValues3 = [];
    // foodValues3.add(200); //porridge
    // foodValues3.add(300); //milk
    // foodValues3.add(500); //meat
    // foodValues3.add(0); //fish
    // foodValues3.add(0); //egg
    // foodValues3.add(100); //green_vegets
    // foodValues3.add(0); //red_vegets
    // foodValues3.add(100); //citrus_fruit
    // for (var i = 0; i < FoodType.values.length; i++) {
    //   foodList3.add(FoodModel(
    //     idBaby: idBaby,
    //     type: FoodType.values[i],
    //     value: foodValues3[i].toDouble(),
    //     updateDate: DateTime(2021, 12, 26),
    //   ));
    // }

    // List<FoodModel> foodList2 = [];
    // List<int> foodValues2 = [];
    // foodValues2.add(500); //porridge
    // foodValues2.add(600); //milk
    // foodValues2.add(0); //meat
    // foodValues2.add(0); //fish
    // foodValues2.add(0); //egg
    // foodValues2.add(100); //green_vegets
    // foodValues2.add(0); //red_vegets
    // foodValues2.add(0); //citrus_fruit
    // for (var i = 0; i < FoodType.values.length; i++) {
    //   foodList2.add(FoodModel(
    //     idBaby: idBaby,
    //     type: FoodType.values[i],
    //     value: foodValues2[i].toDouble(),
    //     updateDate: DateTime(2021, 12, 27),
    //   ));
    // }

    List<FoodModel> foodList1 = [];
    List<int> foodValues1 = [];
    foodValues1.add(0); //porridge
    foodValues1.add(600); //milk
    foodValues1.add(50); //meat
    foodValues1.add(50); //fish
    foodValues1.add(2); //egg
    foodValues1.add(0); //green_vegets
    foodValues1.add(200); //red_vegets
    foodValues1.add(100); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList1.add(FoodModel(
        idBaby: idBaby,
        type: FoodType.values[i],
        value: foodValues1[i].toDouble(),
        updateDate: DateTime(2022, 4, 13),
      ));
    }

    List<FoodModel> foodList0 = [];
    List<int> foodValues0 = [];
    foodValues0.add(500); //porridge
    foodValues0.add(600); //milk
    foodValues0.add(0); //meat
    foodValues0.add(0); //fish
    foodValues0.add(0); //egg
    foodValues0.add(0); //green_vegets
    foodValues0.add(0); //red_vegets
    foodValues0.add(0); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList0.add(FoodModel(
        idBaby: idBaby,
        type: FoodType.values[i],
        value: foodValues0[i].toDouble(),
        updateDate: DateTime(2022, 4, 15),
      ));
    }

    await FoodRepository.createFood(foodList0);
    await FoodRepository.createFood(foodList1);

    return "done";
  }
}
