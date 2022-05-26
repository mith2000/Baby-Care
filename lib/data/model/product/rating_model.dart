// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class RatingModel extends Equatable {
  String id;
  final String content;
  final String idProduct;
  final int ratePoint;
  final String userId;

  void setID(String id) {
    this.id = id;
  }

  RatingModel({
    this.id,
    this.content,
    this.idProduct,
    this.ratePoint,
    this.userId,
  });

  static RatingModel fromSnapshot(Map<String, dynamic> snap) {
    RatingModel ratingModel = RatingModel(
      id: snap['id'],
      content: snap['content'],
      idProduct: snap['idProduct'],
      ratePoint: snap['ratePoint'],
      userId: snap['userId'],
    );
    return ratingModel;
  }

  @override
  List<Object> get props => [id, content, idProduct, ratePoint, userId];

  Map<String, Object> toJson() {
    return {
      "id": id ?? Uuid().v4(),
      "content": content,
      "idProduct": idProduct,
      "ratePoint": ratePoint,
      "userId": userId
    };
  }
}
