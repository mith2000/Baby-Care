import 'package:flutter_babycare/constants/app_constants.dart';

class MealSuggestModel {
  NIType niType;
  List<FoodType> listFoodSuggest;
  NIType get getNiType => this.niType;

  set setNiType(NIType niType) => this.niType = niType;

  get getListFoodSuggest => this.listFoodSuggest;

  set setListFoodSuggest(listFoodSuggest) =>
      this.listFoodSuggest = listFoodSuggest;

  void addFoodToList(FoodType) {
    this.listFoodSuggest.add(FoodType);
  }

  MealSuggestModel({NIType niType, List<FoodType> listFoodSuggest})
      : this.niType = niType,
        this.listFoodSuggest = listFoodSuggest ?? [];
}
