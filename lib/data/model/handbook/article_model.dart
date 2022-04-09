// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ArticleModel extends Equatable {
  String id;
  final String title;
  final String introduction;
  final String category;
  final String header1;
  final String header2;
  final String header3;
  final String header4;
  final String header5;
  final String body1;
  final String body2;
  final String body3;
  final String body4;
  final String body5;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String idTip;

  void setID(String id) {
    this.id = id;
  }

  ArticleModel({
    this.id,
    this.title,
    this.introduction,
    this.category,
    this.header1,
    this.header2,
    this.header3,
    this.header4,
    this.header5,
    this.body1,
    this.body2,
    this.body3,
    this.body4,
    this.body5,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.idTip,
  });

  static ArticleModel fromSnapshot(DocumentSnapshot snap) {
    ArticleModel listArticleModel = ArticleModel(
        id: snap['id'],
        title: snap['title'],
        introduction: snap['introduction'],
        category: snap['category'],
        header1: snap['header1'],
        header2: snap['header2'],
        header3: snap['header3'],
        header4: snap['header4'],
        header5: snap['header5'],
        body1: snap['body1'],
        body2: snap['body2'],
        body3: snap['body3'],
        body4: snap['body4'],
        body5: snap['body5'],
        image1: snap['image1'],
        image2: snap['image2'],
        image3: snap['image3'],
        image4: snap['image4'],
        image5: snap['image5'],
        idTip: snap['idTip']);
    return listArticleModel;
  }

  @override
  List<Object> get props => [
        id,
        title,
        introduction,
        category,
        header1,
        header2,
        header3,
        header4,
        header5,
        body1,
        body2,
        body3,
        body4,
        body5,
        image1,
        image2,
        image3,
        image4,
        image5,
        idTip,
      ];

  Map<String, Object> toJson() {
    return {
      "id": id ?? Uuid().v4(),
      "title": title,
      "introduction": introduction,
      "header1": header1,
      "header2": header2,
      "header3": header3,
      "header4": header4,
      "header5": header5,
      "category": category,
      "body1": body1,
      "body2": body2,
      "body3": body3,
      "body4": body4,
      "body5": body5,
      "image1": image1,
      "image2": image2,
      "image3": image3,
      "image4": image4,
      "image5": image5,
      "idTip": idTip
    };
  }
}
