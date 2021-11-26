import 'package:intl/intl.dart';

class Convert {
  static BirthTimeToDouble(String textBirthController) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    String string = dateFormat.format(DateTime.now());
    var parts = string.split(' ');
    var temp = parts.toString().split('/');
    var temp2 = textBirthController.toString().split('/');
    double temp3 = ((double.parse((temp[2].split(']'))[0].toString()) -
            double.parse(temp2[2].toString())) +
        (double.parse(temp[1].toString()) - double.parse(temp2[1].toString())) +
        (double.parse((temp[0].split('['))[1].toString()) -
            double.parse(temp2[0].toString())))/30;

    return double.parse(temp3.toStringAsFixed(2));
  }
}
