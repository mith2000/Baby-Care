import 'dart:async';

import 'package:flutter_babycare/data/source/handbook/handbook_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/handbook/article_model.dart';
import '../../../data/model/handbook/category_handbook_model.dart';
import '../../../data/model/handbook/theme_handbook_model.dart';
import '../../../data/source/handbook/handbook_repository.dart';
import 'handbook_event.dart';
import 'handbook_state.dart';

class HandBookBloc extends Bloc<HandBookEvent, HandBookState> {
  HandBookBloc() : super(HandBookInitial());

  @override
  Stream<HandBookState> mapEventToState(HandBookEvent event) async* {
    //Theme
    if (event is LoadThemeHandBook) {
      yield HandBookLoading();
      yield* mapLoadThemeHandBookToState(event);
    }
    //List_article
    if (event is LoadListArticle) {
      yield HandBookLoading();
      yield* mapLoadListArticleToState(event);
    }
    //Article
    if (event is LoadArticle) {
      yield HandBookLoading();
      yield* mapLoadArticleToState(event);
    }
  }

  Stream<HandBookState> mapLoadThemeHandBookToState(
      LoadThemeHandBook event) async* {
    List<ThemeHandBookModel> listTheme = [];
    listTheme = await HandBookRepository.fetchAllThemeHandBook();
    yield LoadedTheme(list: listTheme);
  }

  Stream<HandBookState> mapLoadListArticleToState(
      LoadListArticle event) async* {
    List<CategoryHandBookModel> list = [];
    list = await HandBookRepository.fetchListArticle(event.themeID);
    yield LoadedListArticle(list: list);
  }

  Stream<HandBookState> mapLoadArticleToState(LoadArticle event) async* {
    ArticleModel articleModel;
    articleModel = await HandBookRepository.fetchArticle(event.idTip);
    yield LoadedArticle(articleModel: articleModel);
  }
}
