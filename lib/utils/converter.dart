import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:intl/intl.dart';

class Converter {
  static dateToDouble(String textBirthController) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    String string = dateFormat.format(DateTime.now());
    var parts = string.split(' ');
    var temp = parts.toString().split('/');
    var temp2 = textBirthController.toString().split('/');
    double temp3 = ((double.parse((temp[2].split(']'))[0].toString()) -
                    double.parse(temp2[2].toString())) *
                12 +
            (double.parse(temp[1].toString()) -
                    double.parse(temp2[1].toString())) *
                30 +
            (double.parse((temp[0].split('['))[1].toString()) -
                double.parse(temp2[0].toString()))) /
        30;

    return double.parse(temp3.toStringAsFixed(2));
  }

  static NIType stringToNIType(String content) {
    switch (content) {
      case 'Porridge':
        return NIType.Porridge;
      case 'Milk':
        return NIType.Milk;
      case 'Meat':
        return NIType.Meat;
      case 'Fish':
        return NIType.Fish;
      case 'Egg':
        return NIType.Egg;
      case 'Green_Vegets':
        return NIType.Green_Vegets;
      case 'Red_Vegets':
        return NIType.Red_Vegets;
      default:
        return NIType.Citrus_Fruit;
    }
  }

  static String niTypeToString(NIType niType) {
    switch (niType) {
      case NIType.Porridge:
        return 'Porridge';
      case NIType.Milk:
        return 'Milk';
      case NIType.Meat:
        return 'Meat';
      case NIType.Fish:
        return 'Fish';
      case NIType.Egg:
        return 'Egg';
      case NIType.Green_Vegets:
        return 'Green_Vegets';
      case NIType.Red_Vegets:
        return 'Red_Vegets';
      default:
        return 'Citrus_Fruit';
    }
  }
}
