import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';
import 'package:flutter_babycare/data/source/recommender/recommend_repository.dart';
import 'package:uuid/uuid.dart';

import '../../model/product/listhotandsimilarproduct_model.dart';

class ProductRepository {
  static Future<List<ProductModel>> fetchFullProduct(String tagName) async {
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

  static Future<List<ProductModel>> fetchListHotProduct() async {
    List listIdDynamic = await RecommendRepository.getOutstandingProducts();
    List<String> listId = listIdDynamic.map((e) => e.toString()).toList();
    List<ProductModel> listProduct = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('product')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data();
          for (var item in listId) {
            if (item == data['id'].toString()) {
              listProduct.add(ProductModel.fromSnapshot(data));
            }
          }
        });
      }).catchError((error) {
        print(error);
      });
    } catch (error) {
      print(error);
      return null;
    }

    return listProduct;
  }

  static Future<List<ProductModel>> fetchListRecommendProduct(
      String idProduct, String tagName) async {
    List listIdDynamic =
        await RecommendRepository.getSimilarProducts(idProduct);
    List<String> listId = listIdDynamic.map((e) => e.toString()).toList();
    List<ProductModel> listProduct = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('product')
          .where('tagName', isEqualTo: tagName)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data();
          for (var item in listId) {
            if (item == data['id'].toString()) {
              listProduct.add(ProductModel.fromSnapshot(data));
            }
          }
        });
      }).catchError((error) {
        print(error);
      });
    } catch (error) {
      print(error);
      return null;
    }

    return listProduct;
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

  static Future<ListHotAndSimilarModel> getHotAndSimilarProduct(
      String idProduct, String tagName) async {
    ListHotAndSimilarModel listHotAndSimilarModel;

    List<ProductModel> listProduct;
    listProduct = await fetchListRecommendProduct(idProduct, tagName);
    listHotAndSimilarModel.setListSimilarProduct(listProduct);
    listProduct = await fetchListHotProduct();
    listHotAndSimilarModel.setListHotProduct(listProduct);

    return listHotAndSimilarModel;
  }
}
