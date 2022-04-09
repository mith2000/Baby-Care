// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class CategoryHandBookModel extends Equatable {
  String id;
  final String title;
  final String urlImage;
  final String induction;
  final String category;
  final String themeId;

  void setID(String id) {
    this.id = id;
  }

  CategoryHandBookModel(
      {this.id,
      this.title,
      this.urlImage,
      this.induction,
      this.category,
      this.themeId});

  static CategoryHandBookModel fromSnapshot(Map<String, dynamic> snap) {
    CategoryHandBookModel listArticleModel = CategoryHandBookModel(
      id: snap['id'],
      title: snap['title'],
      urlImage: snap['urlImage'],
      induction: snap['induction'],
      category: snap['category'],
      themeId: snap['themeId'],
    );
    return listArticleModel;
  }

  @override
  List<Object> get props => [id, title, urlImage, induction, category, themeId];

  Map<String, Object> toJson() {
    return {
      "id": id ?? Uuid().v4(),
      "title": title,
      "urlImage": urlImage,
      "induction": induction,
      "category": category,
      "themeId": themeId
    };
  }
}
