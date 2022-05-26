// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';

abstract class RecommenderEvent extends Equatable {
  final String tagName;
  const RecommenderEvent({this.tagName});

  @override
  List<Object> get props => [];
}

class LoadListHotProduct extends RecommenderEvent {
  LoadListHotProduct() : super();

  @override
  List<Object> get props => [];
}

class LoadFullListProduct extends RecommenderEvent {
  LoadFullListProduct() : super();

  @override
  List<Object> get props => [];
}

class LoadListRecommendProduct extends RecommenderEvent {
  final String idProduct;
  LoadListRecommendProduct({this.idProduct}) : super();

  @override
  List<Object> get props => [];
}

class UpdateProduct extends RecommenderEvent {
  final ProductModel productModel;

  UpdateProduct({this.productModel});

  @override
  List<Object> get props => [];
}

class CreateProduct extends RecommenderEvent {
  final ProductModel productModel;

  CreateProduct({this.productModel});

  @override
  List<Object> get props => [];
}
