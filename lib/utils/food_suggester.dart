import 'package:flutter_babycare/constants/app_constants.dart';

class FoodSuggester {
  static List<FoodType> getFoodSuggest(NIType type) {
    List<FoodType> suggestFoods = [];
    switch (type) {
      case NIType.Carbohydrate:
        suggestFoods.add(FoodType.Porridge);
        suggestFoods.add(FoodType.Milk);
        suggestFoods.add(FoodType.Green_Vegets);
        suggestFoods.add(FoodType.Red_Vegets);
        break;
      case NIType.Fat:
        suggestFoods.add(FoodType.Porridge);
        suggestFoods.add(FoodType.Meat);
        suggestFoods.add(FoodType.Fish);
        suggestFoods.add(FoodType.Egg);
        break;
      case NIType.Protein:
        suggestFoods.add(FoodType.Porridge);
        suggestFoods.add(FoodType.Milk);
        suggestFoods.add(FoodType.Meat);
        suggestFoods.add(FoodType.Fish);
        suggestFoods.add(FoodType.Egg);
        break;
      case NIType.Vitamin_A:
        suggestFoods.add(FoodType.Milk);
        suggestFoods.add(FoodType.Egg);
        suggestFoods.add(FoodType.Citrus_Fruit);
        break;
      case NIType.Vitamin_B:
        suggestFoods.add(FoodType.Porridge);
        suggestFoods.add(FoodType.Milk);
        suggestFoods.add(FoodType.Egg);
        suggestFoods.add(FoodType.Red_Vegets);
        suggestFoods.add(FoodType.Citrus_Fruit);
        break;
      case NIType.Vitamin_C:
        suggestFoods.add(FoodType.Green_Vegets);
        suggestFoods.add(FoodType.Citrus_Fruit);
        break;
      case NIType.Vitamin_D:
        suggestFoods.add(FoodType.Milk);
        suggestFoods.add(FoodType.Citrus_Fruit);
        break;
      case NIType.Iron:
        suggestFoods.add(FoodType.Meat);
        suggestFoods.add(FoodType.Egg);
        break;
      case NIType.Calcium:
        suggestFoods.add(FoodType.Milk);
        break;
      case NIType.Iodine:
        suggestFoods.add(FoodType.Milk);
        break;
      default:
        break;
    }

    return suggestFoods;
  }
}
