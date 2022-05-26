import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';
import 'package:uuid/uuid.dart';

class ProductRepository {
  static Future<List<ProductModel>> fetchProduct(String tagName) async {
    List<ProductModel> list;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('product')
          .where('tagName', isEqualTo: tagName)
          .get();
      list = snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc.data()))
          .toList();
    } catch (error) {
      print(error);
      return null;
    }
    return list;
  }

  static Future<String> createProduct(ProductModel productModel) async {
    if (productModel.id == null) {
      String idProduct = Uuid().v4();
      productModel.setID(idProduct);
    }
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('product').doc(productModel.id);
    documentReferencer
        .set(productModel.toJson())
        .whenComplete(() => print("product added to the database"))
        .catchError((e) => print(e));
    return "product added to the database";
  }

  static Future<String> updateProduct({ProductModel productModel}) async {
    DocumentReference documentReferencer = await FirebaseFirestore.instance
        .collection('product')
        .doc(productModel.id);
    documentReferencer
        .update(productModel.toJson())
        .whenComplete(() => print("Product updated in the database"))
        .catchError((e) => print(e));
    return "Product updated in the database";
  }
}
