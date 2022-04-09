import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/handbook/article_model.dart';
import 'package:flutter_babycare/data/model/handbook/category_handbook_model.dart';
import 'package:flutter_babycare/data/model/handbook/theme_handbook_model.dart';

class HandBookRepository {
  // Theme
  static Future<List<ThemeHandBookModel>> fetchAllThemeHandBook() async {
    List<ThemeHandBookModel> list;
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('handbook_theme').get();
      list = snapshot.docs
          .map((doc) => ThemeHandBookModel.fromSnapshot(doc.data()))
          .toList();
    } catch (error) {
      print(error);
      return null;
    }
    return list;
  }

  //List_article
  static Future<List<CategoryHandBookModel>> fetchListArticle(
      String themeID) async {
    List<CategoryHandBookModel> list;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('tip_info')
          .where('themeId', isEqualTo: themeID)
          .get();
      list = snapshot.docs
          .map((doc) => CategoryHandBookModel.fromSnapshot(doc.data()))
          .toList();
    } catch (error) {
      print(error);
      return null;
    }
    return list;
  }

  //Article
  static Future<ArticleModel> fetchArticle(String idTip) async {
    List<ArticleModel> babyModel;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('tip_detail')
          .where('idTip', isEqualTo: idTip)
          .get();
      babyModel = snapshot.docs
          .map((doc) => ArticleModel.fromSnapshot(doc.data()))
          .toList();
    } catch (error) {
      print(error);
      return null;
    }
    return babyModel[0];
  }
}
