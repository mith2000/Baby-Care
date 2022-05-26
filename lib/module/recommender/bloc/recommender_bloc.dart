import 'dart:async';

import 'package:flutter_babycare/data/model/product/product_model.dart';
import 'package:flutter_babycare/data/source/recommender/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'recommender_event.dart';
import 'recommender_state.dart';

class RecommenderBloc extends Bloc<RecommenderEvent, RecommenderState> {
  RecommenderBloc() : super(RecommenderInitial());

  @override
  Stream<RecommenderState> mapEventToState(RecommenderEvent event) async* {
    //Product
    if (event is LoadFullListProduct) {
      yield RecommenderLoading();
      yield* mapLoadFullListProductToState(event);
    }
    if (event is LoadListHotProduct) {
      yield RecommenderLoading();
      yield* mapLoadListHotProductToState(event);
    }
    if (event is LoadListRecommendProduct) {
      yield RecommenderLoading();
      yield* mapLoadListRecommendProductToState(event);
    }
  }
}

Stream<RecommenderState> mapLoadListRecommendProductToState(
    LoadListRecommendProduct event) async* {
  List<ProductModel> list = [];
  list = await ProductRepository.fetchListRecommendProduct(
      event.idProduct, event.tagName);
  yield LoadedListProduct(list: list);
}

Stream<RecommenderState> mapLoadListHotProductToState(
    LoadListHotProduct event) async* {
  List<ProductModel> list = [];
  list = await ProductRepository.fetchListHotProduct(event.tagName);
  yield LoadedListProduct(list: list);
}

Stream<RecommenderState> mapLoadFullListProductToState(
    LoadFullListProduct event) async* {
  List<ProductModel> list = [];
  list = await ProductRepository.fetchFullProduct(event.tagName);
  yield LoadedListProduct(list: list);
}
