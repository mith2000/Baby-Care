import 'package:flutter_babycare/data/model/baby/food_model.dart';

import '../../constants/app_constants.dart';
import '../model/baby/food_model.dart';

class LocalDataSource {
  static List<FoodModel> fetchBreakfastSuggest(int dayNext) {
    List<FoodModel> foodListBreakfast = [];
    switch (dayNext) {
      case 1:
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Green_Vegets,
          value: 50.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Red_Vegets,
          value: 20.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 2:
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Citrus_Fruit,
          value: 50.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Fish,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 3:
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Egg,
          value: 2.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Meat,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 4:
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Fish,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Green_Vegets,
          value: 50.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Citrus_Fruit,
          value: 50.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 5:
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Egg,
          value: 1.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Fish,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 6:
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Egg,
          value: 2.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Meat,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 7:
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Egg,
          value: 1.0,
          updateDate: DateTime.now(),
        ));
        foodListBreakfast.add(FoodModel(
          idBaby: '',
          type: FoodType.Green_Vegets,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      default:
        break;
    }
    return foodListBreakfast;
  }

  static List<FoodModel> fetchNoonSuggest(int dayNext) {
    List<FoodModel> foodListNoon = [];
    switch (dayNext) {
      case 1:
        foodListNoon.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 200.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 2:
        foodListNoon.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 200.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 3:
        foodListNoon.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 200.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 4:
        foodListNoon.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 200.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 5:
        foodListNoon.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 200.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 6:
        foodListNoon.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 200.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 7:
        foodListNoon.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 200.0,
          updateDate: DateTime.now(),
        ));
        break;
      default:
        break;
    }
    return foodListNoon;
  }

  static List<FoodModel> fetchDinnerSuggest(int dayNext) {
    List<FoodModel> foodListDinner = [];
    switch (dayNext) {
      case 1:
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Green_Vegets,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 2:
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Red_Vegets,
          value: 50.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 3:
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Fish,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Citrus_Fruit,
          value: 50.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 4:
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Meat,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 5:
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Fish,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 6:
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Fish,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Green_Vegets,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      case 7:
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Porridge,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Red_Vegets,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        foodListDinner.add(FoodModel(
          idBaby: '',
          type: FoodType.Milk,
          value: 100.0,
          updateDate: DateTime.now(),
        ));
        break;
      default:
        break;
    }
    return foodListDinner;
  }
}
