// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ArticleModel extends Equatable {
  String id;
  final String header1;
  final String header2;
  final String header3;
  final String body1;
  final String body2;
  final String body3;
  final String urlImage;
  final String category;
  final String idTip;

  void setID(String id) {
    this.id = id;
  }

  ArticleModel(
      {this.id,
      this.header1,
      this.header2,
      this.header3,
      this.body1,
      this.body2,
      this.body3,
      this.urlImage,
      this.category,
      this.idTip});

  static ArticleModel fromSnapshot(DocumentSnapshot snap) {
    ArticleModel listArticleModel = ArticleModel(
        id: snap['id'],
        header1: snap['header1'],
        header2: snap['header2'],
        header3: snap['header3'],
        body1: snap['body1'],
        body2: snap['body2'],
        body3: snap['body3'],
        urlImage: snap['urlImage'],
        category: snap['category'],
        idTip: snap['idTip']);
    return listArticleModel;
  }

  @override
  List<Object> get props => [
        id,
        header1,
        header2,
        header3,
        body1,
        body2,
        body3,
        urlImage,
        category,
        idTip
      ];

  Map<String, Object> toJson() {
    return {
      "id": id ?? Uuid().v4(),
      "header1": header1,
      "header2": header2,
      "header3": header3,
      "body1": body1,
      "body2": body2,
      "body3": body3,
      "urlImage": urlImage,
      "category": category,
      "idTip": idTip
    };
  }
}
