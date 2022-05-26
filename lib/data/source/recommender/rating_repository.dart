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
