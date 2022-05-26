import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';
import 'package:flutter_babycare/data/model/product/rating_model.dart';
import 'package:flutter_babycare/data/source/baby/food_repository.dart';
import 'package:flutter_babycare/data/source/recommender/product_repository.dart';
import 'package:flutter_babycare/data/source/recommender/rating_repository.dart';
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

  static Future<String> createProduct() async {
    List<ProductModel> list = [];
    list.add(ProductModel(
        id: "2",
        url: "links",
        primaryImage: "image",
        basePrice: 20000,
        name: "Ta 2",
        salePercent: 20,
        tagName: "diapers",
        ratePoint: 3,
        rateCount: 2,
        totalBought: 3,
        shopLocation: "Ha Noi",
        type: "Giay"));
    list.add(ProductModel(
        id: "3",
        url: "links",
        primaryImage: "image",
        basePrice: 20000,
        name: "Ta 3",
        salePercent: 20,
        tagName: "diapers",
        ratePoint: 5,
        rateCount: 3,
        totalBought: 3,
        shopLocation: "TPHCM",
        type: "Vai"));
    list.add(ProductModel(
        id: "4",
        url: "links",
        primaryImage: "image",
        basePrice: 20000,
        name: "Ta 4",
        salePercent: 20,
        tagName: "diapers",
        ratePoint: 4,
        rateCount: 6,
        totalBought: 2,
        shopLocation: "Ha Noi",
        type: "Giay"));
    list.add(ProductModel(
        id: "5",
        url: "links",
        primaryImage: "image",
        basePrice: 20000,
        name: "Ta 5",
        salePercent: 20,
        tagName: "diapers",
        ratePoint: 5,
        rateCount: 2,
        totalBought: 3,
        shopLocation: "TPHCM",
        type: "Vai"));
    list.add(
      ProductModel(
          id: "6",
          url: "links",
          primaryImage: "image",
          basePrice: 40000,
          name: "Ta 6",
          salePercent: 20,
          tagName: "diapers",
          ratePoint: 3,
          rateCount: 2,
          totalBought: 2,
          shopLocation: "Ha Noi",
          type: "Giay"),
    );
    list.add(ProductModel(
        id: "7",
        url: "links",
        primaryImage: "image",
        basePrice: 20000,
        name: "Ta 7",
        salePercent: 20,
        tagName: "diapers",
        ratePoint: 2,
        rateCount: 4,
        totalBought: 5,
        shopLocation: "TPHCM",
        type: "Giay"));
    list.add(ProductModel(
        id: "8",
        url: "links",
        primaryImage: "image",
        basePrice: 40000,
        name: "Ta 8",
        salePercent: 30,
        tagName: "diapers",
        ratePoint: 5,
        rateCount: 2,
        totalBought: 5,
        shopLocation: "Ha noi",
        type: "Vai"));
    list.add(ProductModel(
        id: "9",
        url: "links",
        primaryImage: "image",
        basePrice: 50000,
        name: "Ta 9",
        salePercent: 45,
        tagName: "diapers",
        ratePoint: 4,
        rateCount: 6,
        totalBought: 2,
        shopLocation: "Ha Noi",
        type: "Giay"));
    list.add(ProductModel(
        id: "10",
        url: "links",
        primaryImage: "image",
        basePrice: 40000,
        name: "Ta 10",
        salePercent: 20,
        tagName: "diapers",
        ratePoint: 3,
        rateCount: 5,
        totalBought: 5,
        shopLocation: "TPHCM",
        type: "Vai"));
    list.add(
      ProductModel(
          id: "11",
          url: "links",
          primaryImage: "image",
          basePrice: 60000,
          name: "Ta 1",
          salePercent: 10,
          tagName: "diapers",
          ratePoint: 5,
          rateCount: 6,
          totalBought: 2,
          shopLocation: "Ha Noi",
          type: "Vai"),
    );

    for (var i = 0; i < list.length; i++) {
      await ProductRepository.createProduct(list[i]);
    }

    return "done";
  }

  static Future<String> createRating() async {
    var listModel = [
      RatingModel(
          id: "2",
          content: "good",
          idProduct: "1",
          ratePoint: 4,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "3",
          content: "hay",
          idProduct: "1",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "4",
          content: "OK",
          idProduct: "1",
          ratePoint: 3,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "5",
          content: "hay",
          idProduct: "1",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "6",
          content: "good",
          idProduct: "1",
          ratePoint: 2,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "7",
          content: "hay",
          idProduct: "1",
          ratePoint: 2,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "8",
          content: "OK",
          idProduct: "1",
          ratePoint: 4,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "9",
          content: "bad",
          idProduct: "1",
          ratePoint: 1,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "2",
          content: "good",
          idProduct: "1",
          ratePoint: 4,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "10",
          content: "hay",
          idProduct: "2",
          ratePoint: 1,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "11",
          content: "OK",
          idProduct: "2",
          ratePoint: 3,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "12",
          content: "hay",
          idProduct: "2",
          ratePoint: 5,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "13",
          content: "good",
          idProduct: "2",
          ratePoint: 4,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "14",
          content: "hay",
          idProduct: "3",
          ratePoint: 4,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "15",
          content: "OK",
          idProduct: "2",
          ratePoint: 2,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
      RatingModel(
          id: "16",
          content: "bad",
          idProduct: "2",
          ratePoint: 1,
          userId: "4GxRYoBYNDXo0nBt6VfUTJc5VXG3"),
    ];

    List<RatingModel> list = [];
    list.addAll(listModel);
    for (var i = 0; i < list.length; i++) {
      await RatingRepository.createRating(list[i]);
    }

    return "done";
  }
}
