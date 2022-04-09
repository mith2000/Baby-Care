// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ThemeHandBookModel extends Equatable {
  String id;
  final String title;
  final String urlImage;
  final String description;

  void setID(String id) {
    this.id = id;
  }

  ThemeHandBookModel({
    this.id,
    this.title,
    this.urlImage,
    this.description,
  });

  static ThemeHandBookModel fromSnapshot(Map<String, dynamic> snap) {
    ThemeHandBookModel babyModel = ThemeHandBookModel(
      id: snap['id'],
      title: snap['title'],
      urlImage: snap['urlImage'],
      description: snap['description'],
    );
    return babyModel;
  }

  @override
  List<Object> get props => [
        id,
        title,
        urlImage,
        description,
      ];

  Map<String, Object> toJson() {
    return {
      "id": id ?? Uuid().v4(),
      "title": title,
      "urlImage": urlImage,
      "description": description,
    };
  }
}
