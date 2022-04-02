import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:flutter_babycare/data/model/list_food_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';
import 'package:flutter_babycare/data/source/ni_repository.dart';
import 'package:flutter_babycare/utils/converter.dart';
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
    List<FoodModel> listFoodRecent =
        await fetchFoodToUpdate(listFoodModel[0].idBaby);
    bool isOverDay = false;
    double temp = 10000;
    int maxCountUpdate;
    await FirebaseFirestore.instance
        .collection('food')
        .where('idBaby', isEqualTo: listFoodModel[0].idBaby)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        double date = Converter.dateToDayDouble(
            DateFormat('dd/MM/yyyy').format(doc.data()['updateDate'].toDate()));
        if (temp >= date) {
          temp = date;
          maxCountUpdate = doc.data()['countUpdate'];
        }
      });
    });

    await FirebaseFirestore.instance
        .collection('food')
        .where('idBaby', isEqualTo: listFoodModel[0].idBaby)
        .where('countUpdate', isEqualTo: maxCountUpdate)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.data()['type'] ==
            Converter.FoodTypeToUnitString(FoodType.Egg)) {
          if (Converter.checkOverDay(doc.data()['updateDate'].toDay())) {
            isOverDay = true;
          }
        }
      });
    });

    for (var i = 0; i < listFoodModel.length; i++) {
      if (isOverDay) {
        listFoodModel[i].setCountUpdate(maxCountUpdate + 1);
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
    List<FoodModel> list = [];
    await FirebaseFirestore.instance
        .collection('food')
        .where('idBaby', isEqualTo: idBaby)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        list.add(FoodModel.fromSnapshot(doc));
        int date = Converter.dateToDayDouble(DateFormat('dd/MM/yyyy')
                .format(doc.data()['updateDate'].toDate()))
            .toInt();
        if (date <= dayAgo) {
          listFood.elementAt(date).listFood.add(FoodModel.fromSnapshot(doc));
        }
      });
    });
    List<FoodModel> temp = list;
    List<FoodModel> temp1 = temp;
    return listFood;
  }

  static Future<List<FoodModel>> fetchFoodToUpdate(String idBaby) async {
    List<FoodModel> listFood = [];
    int maxCountUpdate;
    double temp = 10000;
    await FirebaseFirestore.instance
        .collection('food')
        .where('idBaby', isEqualTo: idBaby)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        double date = Converter.dateToDayDouble(
            DateFormat('dd/MM/yyyy').format(doc.data()['updateDate'].toDate()));
        if (temp >= date) {
          temp = date;
          maxCountUpdate = doc.data()['countUpdate'];
        }
      });
    });
    await FirebaseFirestore.instance
        .collection('food')
        .where('idBaby', isEqualTo: idBaby)
        .where('countUpdate', isEqualTo: maxCountUpdate)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listFood.add(FoodModel.fromSnapshot(doc));
      });
    });
    return listFood;
  }
}
