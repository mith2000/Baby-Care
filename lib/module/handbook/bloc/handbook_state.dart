// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/handbook/article_model.dart';
import 'package:flutter_babycare/data/model/handbook/category_handbook_model.dart';
import 'package:flutter_babycare/data/model/handbook/theme_handbook_model.dart';

class HandBookState extends Equatable {
  @override
  List<Object> get props => [];
}

class HandBookInitial extends HandBookState {}

class LoadedTheme extends HandBookState {
  final List<ThemeHandBookModel> list;

  LoadedTheme({this.list});

  @override
  List<Object> get props => [list];
}

class LoadedListArticle extends HandBookState {
  final List<CategoryHandBookModel> list;

  LoadedListArticle({this.list});

  @override
  List<Object> get props => [list];
}

class LoadedArticle extends HandBookState {
  final ArticleModel articleModel;

  LoadedArticle({this.articleModel});

  @override
  List<Object> get props => [articleModel];
}

class HandBookLoading extends HandBookState {}

class ThemeLoadFailure extends HandBookState {}
