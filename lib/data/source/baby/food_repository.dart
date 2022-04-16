import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants/app_constants.dart';
import '../../model/baby/food_model.dart';
import '../../model/baby/list_food_model.dart';
import '../../model/baby/ni_model.dart';
import 'ni_repository.dart';
import '../../../utils/converter.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class FoodRepository {
  static Future<String> createFood(List<FoodModel> listFoodModel) async {
    for (var i = 0; i < listFoodModel.length; i++) {
      String idFood = Uuid().v4();
      listFoodModel[i].setId(idFood);
      DocumentReference documentReferencer =
          FirebaseFirestore.instance.collection('food').doc(idFood);
      String temp = listFoodModel[i].type.toString();
      await documentReferencer
          .set(listFoodModel[i].toJson())
          .whenComplete(() => print("$temp food added to the database"))
          .catchError((e) => print(e));

      List<NIModel> listNi = Converter.foodToNI(listFoodModel[i]);

      for (var j = 0; j < listNi.length; j++) {
        await NIRepository.createNi(listNi[j], listFoodModel[0].idBaby);
      }
    }
    return listFoodModel[0].idBaby;
  }

  static Future<String> updateFood(List<FoodModel> listFoodModel) async {
    List<ListFoodModel> list = await fetchFood(listFoodModel[0].idBaby, 0);
    List<FoodModel> listFoodRecent = list[0].listFood;
    bool isOverDay = true;

    await FirebaseFirestore.instance
        .collection('food')
        .where('idBaby', isEqualTo: listFoodModel[0].idBaby)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.data()['updateDate'].toDate().day == DateTime.now().day &&
            doc.data()['updateDate'].toDate().month == DateTime.now().month &&
            doc.data()['updateDate'].toDate().year == DateTime.now().year) {
          isOverDay = false;
        }
      });
    });

    for (var i = 0; i < listFoodModel.length; i++) {
      if (isOverDay) {
        String idFood = Uuid().v4();
        listFoodModel[i].setId(idFood);
        DocumentReference documentReferencer =
            FirebaseFirestore.instance.collection('food').doc(idFood);
        String temp = listFoodModel[i].type.toString();
        await documentReferencer
            .set(listFoodModel[i].toJson())
            .whenComplete(() => print("$temp food added to the database"))
            .catchError((e) => print(e));
      } else {
        for (var j = 0; j < listFoodRecent.length; j++) {
          if (listFoodRecent[j].type == listFoodModel[i].type) {
            listFoodModel[i].setId(listFoodRecent[j].id);
            listFoodModel[i].setValue(
                listFoodRecent[j].getValue() + listFoodModel[i].getValue());
            DocumentReference documentReferencer = FirebaseFirestore.instance
                .collection('food')
                .doc(listFoodRecent[j].id);
            documentReferencer
                .update(listFoodModel[i].toJson())
                .whenComplete(() => print("Food updated in the database"))
                .catchError((e) => print(e));
          }
        }
      }
      List<NIModel> listNi = Converter.foodToNI(listFoodModel[i]);

      for (var j = 0; j < listNi.length; j++) {
        await NIRepository.createNi(listNi[j], listFoodModel[0].idBaby);
      }
    }
    return listFoodModel[0].idBaby;
  }

  static Future<List<ListFoodModel>> fetchFood(
      String idBaby, int dayAgo) async {
    //dayAgo là số ngày cần lấy, ví dụ: dayAgo = 7 là lấy Food 7 ngày trước (sẽ có ngày list Food bị rỗng)
    // dayAgo = 0 là food ngày hiện tại
    List<ListFoodModel> listFood = [];
    for (var i = 0; i <= dayAgo; i++) {
      listFood.add(ListFoodModel(dayAgo: i));
    }

    for (var i = 0; i < dayAgo; i++) {
      await FirebaseFirestore.instance
          .collection('food')
          .where('idBaby', isEqualTo: idBaby)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc.data()['updateDate'].toDate().day ==
                  DateTime.now().subtract(Duration(days: i)).day &&
              doc.data()['updateDate'].toDate().month ==
                  DateTime.now().subtract(Duration(days: i)).month &&
              doc.data()['updateDate'].toDate().year ==
                  DateTime.now().subtract(Duration(days: i)).year) {
            listFood.elementAt(i).listFood.add(FoodModel.fromSnapshot(doc));
          }
        });
      });
    }
    return listFood;
  }
}
