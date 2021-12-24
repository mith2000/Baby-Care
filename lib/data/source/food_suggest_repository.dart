import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/meal_suggest_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';

import 'ni_repository.dart';

class FoodSuggestRepository {
  final FirebaseFirestore firebaseFirestore;
  final NIRepository niRepository;

  FoodSuggestRepository(
      {FirebaseFirestore firebaseFirestore, NIRepository niRepository})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance,
        this.niRepository = niRepository ?? new NIRepository();

  List<MealSuggestModel> mealSuggest(List<NIModel> listNI) {
    List<MealSuggestModel> listMealSuggest = [];
    listNI.forEach((element) {
      listMealSuggest.add(MealSuggestModel(niType: element.type));
    });

    listMealSuggest.forEach((element) {
      switch (element.getNiType) {
        case NIType.Calcium:
          element.listFoodSuggest.add(FoodType.Milk);
          break;
        case NIType.Carbohydrate:
          element.listFoodSuggest.add(FoodType.Milk);
          element.listFoodSuggest.add(FoodType.Porridge);
          element.listFoodSuggest.add(FoodType.Green_Vegets);
          element.listFoodSuggest.add(FoodType.Red_Vegets);
          break;
        case NIType.Fat:
          element.listFoodSuggest.add(FoodType.Porridge);
          element.listFoodSuggest.add(FoodType.Meat);
          element.listFoodSuggest.add(FoodType.Fish);
          element.listFoodSuggest.add(FoodType.Egg);
          break;
        case NIType.Protein:
          element.listFoodSuggest.add(FoodType.Milk);
          element.listFoodSuggest.add(FoodType.Porridge);
          element.listFoodSuggest.add(FoodType.Meat);
          element.listFoodSuggest.add(FoodType.Fish);
          element.listFoodSuggest.add(FoodType.Egg);
          element.listFoodSuggest.add(FoodType.Green_Vegets);
          element.listFoodSuggest.add(FoodType.Red_Vegets);
          break;
        case NIType.Vitamin_A:
          element.listFoodSuggest.add(FoodType.Milk);
          element.listFoodSuggest.add(FoodType.Egg);
          element.listFoodSuggest.add(FoodType.Citrus_Fruit);
          break;
        case NIType.Vitamin_B:
          element.listFoodSuggest.add(FoodType.Milk);
          element.listFoodSuggest.add(FoodType.Red_Vegets);
          element.listFoodSuggest.add(FoodType.Egg);
          element.listFoodSuggest.add(FoodType.Porridge);
          element.listFoodSuggest.add(FoodType.Citrus_Fruit);
          break;
        case NIType.Vitamin_C:
          element.listFoodSuggest.add(FoodType.Green_Vegets);
          element.listFoodSuggest.add(FoodType.Citrus_Fruit);
          break;
        case NIType.Vitamin_D:
          element.listFoodSuggest.add(FoodType.Milk);
          element.listFoodSuggest.add(FoodType.Citrus_Fruit);
          break;
        case NIType.Iron:
          element.listFoodSuggest.add(FoodType.Meat);
          element.listFoodSuggest.add(FoodType.Egg);
          break;
        default:
          element.listFoodSuggest.add(FoodType.Milk);
          break;
      }
    });
    return listMealSuggest;
  }
}
