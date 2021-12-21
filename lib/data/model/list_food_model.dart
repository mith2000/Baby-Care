import 'package:flutter_babycare/data/model/food_model.dart';

class ListFoodModel {
  int dayAgo;
  List<FoodModel> listFood;

  int get getDayAgo => this.dayAgo;

  set setDayAgo(int dayAgo) => this.dayAgo = dayAgo;

  get getListFood => this.listFood;

  set setListFood(listFood) => this.listFood = listFood;

  void addFoodToList(FoodModel) {
    this.listFood.add(FoodModel);
  }

  ListFoodModel({int dayAgo, List<FoodModel> listFood})
      : this.dayAgo = dayAgo ?? 0,
        this.listFood = listFood ?? [];
}
