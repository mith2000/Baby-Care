import 'package:intl/intl.dart';

import '../constants/app_constants.dart';
import '../data/model/baby/food_model.dart';
import '../data/model/baby/ni_model.dart';

class Converter {
  static dateToMonthDouble(String textBirthController) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    String string = dateFormat.format(DateTime.now());
    var parts = string.split(' ');
    var temp = parts.toString().split('/');
    var temp2 = textBirthController.toString().split('/');
    double temp3 = ((double.parse((temp[2].split(']'))[0].toString()) -
                    double.parse(temp2[2].toString())) *
                365 +
            (double.parse(temp[1].toString()) -
                    double.parse(temp2[1].toString())) *
                30 +
            (double.parse((temp[0].split('['))[1].toString()) -
                double.parse(temp2[0].toString()))) /
        30;

    return double.parse(temp3.toStringAsFixed(2));
  }

  static dateToDayDouble(String dateString) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    String string = dateFormat.format(DateTime.now());
    var parts = string.split(' ');
    var temp = parts.toString().split('/');
    var temp2 = dateString.toString().split('/');
    double temp3 = ((double.parse((temp[2].split(']'))[0].toString()) -
                double.parse(temp2[2].toString())) *
            365 +
        (double.parse(temp[1].toString()) - double.parse(temp2[1].toString())) *
            30 +
        (double.parse((temp[0].split('['))[1].toString()) -
            double.parse(temp2[0].toString())));
    return temp3;
  }

  static FoodType stringToFoodType(String content) {
    switch (content) {
      case 'Porridge':
        return FoodType.Porridge;
      case 'Milk':
        return FoodType.Milk;
      case 'Meat':
        return FoodType.Meat;
      case 'Fish':
        return FoodType.Fish;
      case 'Egg':
        return FoodType.Egg;
      case 'Green_Vegets':
        return FoodType.Green_Vegets;
      case 'Red_Vegets':
        return FoodType.Red_Vegets;
      default:
        return FoodType.Citrus_Fruit;
    }
  }

  static String foodTypeToString(FoodType niType) {
    switch (niType) {
      case FoodType.Porridge:
        return 'Porridge';
      case FoodType.Milk:
        return 'Milk';
      case FoodType.Meat:
        return 'Meat';
      case FoodType.Fish:
        return 'Fish';
      case FoodType.Egg:
        return 'Egg';
      case FoodType.Green_Vegets:
        return 'Green_Vegets';
      case FoodType.Red_Vegets:
        return 'Red_Vegets';
      default:
        return 'Citrus_Fruit';
    }
  }

  static NIType stringToNIType(String content) {
    switch (content) {
      case 'Carbohydrate':
        return NIType.Carbohydrate;
      case 'Fat':
        return NIType.Fat;
      case 'Protein':
        return NIType.Protein;
      case 'Vitamin_A':
        return NIType.Vitamin_A;
      case 'Vitamin_B':
        return NIType.Vitamin_B;
      case 'Vitamin_C':
        return NIType.Vitamin_C;
      case 'Vitamin_D':
        return NIType.Vitamin_D;
      case 'Iron':
        return NIType.Iron;
      case 'Calcium':
        return NIType.Calcium;
      default:
        return NIType.Iodine;
    }
  }

  static String niTypeToString(NIType niType) {
    switch (niType) {
      case NIType.Carbohydrate:
        return 'Carbohydrate';
      case NIType.Fat:
        return 'Fat';
      case NIType.Protein:
        return 'Protein';
      case NIType.Vitamin_A:
        return 'Vitamin_A';
      case NIType.Vitamin_B:
        return 'Vitamin_B';
      case NIType.Vitamin_C:
        return 'Vitamin_C';
      case NIType.Vitamin_D:
        return 'Vitamin_D';
      case NIType.Iron:
        return 'Iron';
      case NIType.Calcium:
        return 'Calcium';
      default:
        return 'Iodine';
    }
  }

  static List<NIModel> foodToNI(FoodModel foodModel) {
    switch (foodModel.type) {
      case FoodType.Milk:
        return [
          NIModel(
              type: NIType.Protein,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 41 * foodModel.value / 100),
          NIModel(
              type: NIType.Calcium,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 2 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_B,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 1 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_A,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 1 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_D,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 1 * foodModel.value / 100),
          NIModel(
              type: NIType.Carbohydrate,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 10 * foodModel.value / 100),
          NIModel(
              type: NIType.Iodine,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 5 * foodModel.value / 100)
        ];
      case FoodType.Porridge:
        return [
          NIModel(
              type: NIType.Protein,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 17 * foodModel.value / 100),
          NIModel(
              type: NIType.Fat,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 7 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_B,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 8 * foodModel.value / 100),
          NIModel(
              type: NIType.Carbohydrate,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 10 * foodModel.value / 100),
        ];
      case FoodType.Meat:
        return [
          NIModel(
              type: NIType.Protein,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 25 * foodModel.value / 100),
          NIModel(
              type: NIType.Calcium,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 0.9 * foodModel.value / 100),
          NIModel(
              type: NIType.Iron,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 0.15 * foodModel.value / 100),
          NIModel(
              type: NIType.Fat,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 7 * foodModel.value / 100),
        ];
      case FoodType.Fish:
        return [
          NIModel(
              type: NIType.Protein,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 20 * foodModel.value / 100),
          NIModel(
              type: NIType.Fat,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 7 * foodModel.value / 100),
        ];
      case FoodType.Egg:
        return [
          NIModel(
              type: NIType.Protein,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 14 * foodModel.value / 100),
          NIModel(
              type: NIType.Fat,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 12 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_B,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 0.0129 * foodModel.value / 100),
          NIModel(
              type: NIType.Iron,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 0.27 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_A,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 0.7 * foodModel.value / 100),
        ];
      case FoodType.Green_Vegets:
        return [
          NIModel(
              type: NIType.Carbohydrate,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 4 * foodModel.value / 100),
          NIModel(
              type: NIType.Protein,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 3 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_C,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 28 * foodModel.value / 100),
        ];
      case FoodType.Red_Vegets:
        return [
          NIModel(
              type: NIType.Carbohydrate,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 4 * foodModel.value / 100),
          NIModel(
              type: NIType.Protein,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 3 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_B,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 28 * foodModel.value / 100),
        ];
      default:
        return [
          NIModel(
              type: NIType.Vitamin_D,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 10 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_C,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 7 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_B,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 5 * foodModel.value / 100),
          NIModel(
              type: NIType.Vitamin_A,
              idBaby: foodModel.idBaby,
              updateDate: DateTime.now(),
              value: 8 * foodModel.value / 100),
        ];
    }
  }

  static NIModel getNiInList(List<NIModel> listNI, NIType type) {
    for (var i = 0; i < listNI.length; i++) {
      if (niTypeToString(type) == niTypeToString(listNI[i].type)) {
        return listNI[i];
      }
    }
    return null;
  }

  static String NITypeToTypeString(NIType type) {
    switch (type) {
      case NIType.Carbohydrate:
        return "Carbohydrate";
        break;
      case NIType.Fat:
        return "Fat";
        break;
      case NIType.Protein:
        return "Protein";
        break;
      case NIType.Vitamin_A:
        return "Vitamin A";
        break;
      case NIType.Vitamin_B:
        return "Vitamin B";
        break;
      case NIType.Vitamin_C:
        return "Vitamin C";
        break;
      case NIType.Vitamin_D:
        return "Vitamin D";
        break;
      case NIType.Iron:
        return "Iron";
        break;
      case NIType.Calcium:
        return "Calcium";
        break;
      case NIType.Iodine:
        return "Iodine";
        break;
      default:
        return "Carbohydrate";
        break;
    }
  }

  static String FoodTypeToIconNameString(FoodType type) {
    switch (type) {
      case FoodType.Porridge:
        return "porridge";
        break;
      case FoodType.Milk:
        return "milk";
        break;
      case FoodType.Meat:
        return "meat";
        break;
      case FoodType.Fish:
        return "fish";
        break;
      case FoodType.Egg:
        return "egg";
        break;
      case FoodType.Green_Vegets:
        return "green_vegets";
        break;
      case FoodType.Red_Vegets:
        return "red_vegets";
        break;
      case FoodType.Citrus_Fruit:
        return "citrus_fruit";
        break;
      default:
        return "porridge";
        break;
    }
  }

  static String FoodTypeToUnitString(FoodType type) {
    switch (type) {
      case FoodType.Porridge:
        return "g";
        break;
      case FoodType.Milk:
        return "ml";
        break;
      case FoodType.Meat:
        return "g";
        break;
      case FoodType.Fish:
        return "g";
        break;
      case FoodType.Egg:
        return "u";
        break;
      case FoodType.Green_Vegets:
        return "g";
        break;
      case FoodType.Red_Vegets:
        return "g";
        break;
      case FoodType.Citrus_Fruit:
        return "g";
        break;
      default:
        return "g";
        break;
    }
  }

  static bool checkOverDay(DateTime dateTime) {
    var foodTime = DateFormat('dd/MM/yyyy')
        .format(dateTime)
        .split(' ')
        .toString()
        .split('/');
    var nowTime = DateFormat('dd/MM/yyyy')
        .format(DateTime.now())
        .split(' ')
        .toString()
        .split('/');
    if (foodTime[0] == nowTime[0]) {
      if (foodTime[1] == nowTime[1]) {
        if (foodTime[2] != nowTime[2]) {
          return true;
        }
        return false;
      }
      return true;
    }
    return true;
  }

  static String priceToString(int price) {
    final format = NumberFormat("###,###,###đ", "en_US");
    return format.format(price.truncate());
  }
}
