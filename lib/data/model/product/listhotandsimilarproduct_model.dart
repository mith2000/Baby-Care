// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';

class ListHotAndSimilarModel extends Equatable {
  List<ProductModel> listHotProduct;
  List<ProductModel> listSimilarProduct;

  ListHotAndSimilarModel({this.listHotProduct, this.listSimilarProduct});

  set setListHotProduct(List<ProductModel> _listHotProduct) {
    this.listHotProduct = _listHotProduct;
  }

  set setListSimilarProduct(List<ProductModel> _listSimilarProduct) {
    this.listSimilarProduct = _listSimilarProduct;
  }

  @override
  List<Object> get props => [listHotProduct, listSimilarProduct];
}
