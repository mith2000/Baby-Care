import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../../constants/app_constants.dart';
import '../../../utils/converter.dart';

class FoodSuggestModel extends Equatable {
  final String id;
  final String idBaby;
  final FoodType type;
  double value;
  final DateTime date;

  FoodSuggestModel({
    this.id,
    this.idBaby,
    this.type,
    this.value,
    this.date,
  });

  static FoodSuggestModel fromSnapshot(DocumentSnapshot snap) {
    DateTime myDateTime = snap['date'].toDate();
    FoodSuggestModel babyModel = FoodSuggestModel(
      id: snap['id'],
      idBaby: snap['idBaby'],
      type: Converter.stringToFoodType(snap['type']),
      value: snap['value'],
      date: myDateTime,
    );
    return babyModel;
  }

  @override
  List<Object> get props => [id, idBaby, type, value, date];

  Map<String, Object> toJson() {
    Timestamp myTimeStamp = Timestamp.fromDate(date);
    return {
      "id": id,
      "idBaby": idBaby,
      "type": Converter.foodTypeToString(type),
      "value": value,
      "date": myTimeStamp,
    };
  }
}
