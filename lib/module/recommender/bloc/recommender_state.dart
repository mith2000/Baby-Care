// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/product/listhotandsimilarproduct_model.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';
import 'package:flutter_babycare/data/model/product/rating_model.dart';

class RecommenderState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecommenderInitial extends RecommenderState {}

class LoadedListProduct extends RecommenderState {
  final List<ProductModel> list;

  LoadedListProduct({this.list});

  @override
  List<Object> get props => [list];
}

class LoadedListRating extends RecommenderState {
  final List<RatingModel> list;

  LoadedListRating({this.list});

  @override
  List<Object> get props => [list];
}

class LoadedListHotAndSimilarProduct extends RecommenderState {
  final ListHotAndSimilarModel list;

  LoadedListHotAndSimilarProduct({this.list});

  @override
  List<Object> get props => [list];
}

class RecommenderLoading extends RecommenderState {}

class ThemeLoadFailure extends RecommenderState {}
