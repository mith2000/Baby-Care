import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_constants.dart';
import '../model/food_model.dart';
import '../model/ni_model.dart';
import '../../utils/converter.dart';

import 'ni_repository.dart';

class CreateSampleData {
  NIRepository niRepository;
  CreateSampleData({NIRepository niRepository})
      : this.niRepository = niRepository ?? new NIRepository();

  Future<void> create() async {
    List<FoodModel> foodList4 = [];
    String idBaby = "0e0d1b6a-29a4-4adb-bc65-7b53a9592d0b";
    List<int> foodValues4 = [];
    foodValues4.add(500); //porridge
    foodValues4.add(600); //milk
    foodValues4.add(0); //meat
    foodValues4.add(0); //fish
    foodValues4.add(1); //egg
    foodValues4.add(100); //green_vegets
    foodValues4.add(50); //red_vegets
    foodValues4.add(60); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList4.add(FoodModel(
        idBaby: idBaby,
        type: FoodType.values[i],
        countUpdate: 0,
        value: foodValues4[i].toDouble(),
        updateDate: DateTime(2021, 12, 25),
      ));
    }

    List<FoodModel> foodList3 = [];
    List<int> foodValues3 = [];
    foodValues3.add(200); //porridge
    foodValues3.add(300); //milk
    foodValues3.add(500); //meat
    foodValues3.add(0); //fish
    foodValues3.add(0); //egg
    foodValues3.add(100); //green_vegets
    foodValues3.add(0); //red_vegets
    foodValues3.add(100); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList3.add(FoodModel(
        idBaby: idBaby,
        type: FoodType.values[i],
        countUpdate: 1,
        value: foodValues3[i].toDouble(),
        updateDate: DateTime(2021, 12, 26),
      ));
    }

    List<FoodModel> foodList2 = [];
    List<int> foodValues2 = [];
    foodValues2.add(500); //porridge
    foodValues2.add(600); //milk
    foodValues2.add(0); //meat
    foodValues2.add(0); //fish
    foodValues2.add(0); //egg
    foodValues2.add(100); //green_vegets
    foodValues2.add(0); //red_vegets
    foodValues2.add(0); //citrus_fruit
    for (var i = 0; i < FoodType.values.length; i++) {
      foodList2.add(FoodModel(
        idBaby: idBaby,
        type: FoodType.values[i],
        countUpdate: 2, //ban dau la 2
        value: foodValues2[i].toDouble(),
        updateDate: DateTime(2021, 12, 27),
      ));
    }

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
        countUpdate: 3, // ban dau la 3
        value: foodValues1[i].toDouble(),
        updateDate: DateTime(2021, 12, 28),
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
        countUpdate: 4,
        value: foodValues0[i].toDouble(),
        updateDate: DateTime(2021, 12, 30),
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
        await NIRepository.createNi(listNi[j], list[0].idBaby);
      }
    }
  }
}
