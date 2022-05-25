// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ProductModel extends Equatable {
  String id;
  final String url;
  final String name;
  final String primaryImage;
  final int basePrice;
  final int salePercent;
  final String tagName;
  final double ratePoint;
  final int rateCount;
  final int totalBought;
  final String shopLocation;
  final String type;

  void setID(String id) {
    this.id = id;
  }

  ProductModel(
      {this.id,
      this.url,
      this.name,
      this.primaryImage,
      this.basePrice,
      this.salePercent,
      this.tagName,
      this.ratePoint,
      this.rateCount,
      this.totalBought,
      this.shopLocation,
      this.type});

  static ProductModel fromSnapshot(Map<String, dynamic> snap) {
    ProductModel productModel = ProductModel(
        id: snap['id'],
        url: snap['url'],
        name: snap['name'],
        primaryImage: snap['primaryImage'],
        basePrice: snap['basePrice'],
        salePercent: snap['salePercent'],
        tagName: snap['tagName'],
        ratePoint: snap['ratePoint'],
        rateCount: snap['rateCount'],
        totalBought: snap['totalBought'],
        shopLocation: snap['shopLocation'],
        type: snap['type']);
    return productModel;
  }

  @override
  List<Object> get props => [
        id,
        url,
        name,
        primaryImage,
        basePrice,
        salePercent,
        tagName,
        ratePoint,
        rateCount,
        totalBought,
        shopLocation,
        type
      ];

  Map<String, Object> toJson() {
    return {
      "id": id ?? Uuid().v4(),
      "url": url,
      "name": name,
      "primaryImage": primaryImage,
      "basePrice": basePrice,
      "salePercent": salePercent,
      "tagName": tagName,
      "ratePoint": ratePoint,
      "rateCount": rateCount,
      "totalBought": totalBought,
      "shopLocation": shopLocation,
      "type": type
    };
  }
}
