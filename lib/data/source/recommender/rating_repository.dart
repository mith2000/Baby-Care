import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../model/product/rating_model.dart';

class RatingRepository {
  static Future<List<RatingModel>> fetchRatingForProduct(
      String idProduct) async {
    List<RatingModel> list;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Rating')
          .where('idProduct', isEqualTo: idProduct)
          .get();
      list = snapshot.docs
          .map((doc) => RatingModel.fromSnapshot(doc.data()))
          .toList();
    } catch (error) {
      print(error);
      return null;
    }
    return list;
  }

  static Future<String> createRating(RatingModel ratingModel) async {
    if (ratingModel.id == null) {
      String idRating = Uuid().v4();
      ratingModel.setID(idRating);
    }
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('Rating').doc(ratingModel.id);
    documentReferencer
        .set(ratingModel.toJson())
        .whenComplete(() => print("Rating added to the database"))
        .catchError((e) => print(e));

    double sumRating = 0;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Rating')
          .where('idProduct', isEqualTo: ratingModel.idProduct)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data();
          sumRating += data['ratePoint'];
        });
      }).catchError((error) {
        print(error);
      });
    } catch (error) {
      print(error);
      return null;
    }

    if (sumRating != 0) {
      DocumentReference docRef;
      var batch = FirebaseFirestore.instance.batch();
      String idProduct = ratingModel.idProduct;
      await FirebaseFirestore.instance
          .collection('product')
          .where('id', isEqualTo: ratingModel.idProduct)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
          Map<String, dynamic> data = doc.data();
          docRef = FirebaseFirestore.instance.collection('product').doc(doc.id);
          batch.update(docRef, {'rateCount': data['rateCount'] + 1});
          batch.update(
              docRef, {'ratePoint': sumRating / (data['rateCount'] + 1)});
          batch.commit().then((a) {
            print('updated ratePoint in idProduct: $idProduct');
          });
        });
      }).catchError((error) {
        print(error);
      });
    } else {
      print('cannot update rating in product, because sumRating = 0');
    }

    return "Rating added to the database";
  }

  static Future<String> updateRating({RatingModel ratingModel}) async {
    DocumentReference documentReferencer = await FirebaseFirestore.instance
        .collection('Rating')
        .doc(ratingModel.id);
    documentReferencer
        .update(ratingModel.toJson())
        .whenComplete(() => print("Rating updated in the database"))
        .catchError((e) => print(e));
    return "Rating updated in the database";
  }
}
