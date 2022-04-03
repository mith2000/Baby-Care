// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_babycare/data/model/handbook/theme_handbook_model.dart';

abstract class HandBookEvent extends Equatable {
  final ThemeHandBookModel themeHandBookModel;

  const HandBookEvent({this.themeHandBookModel});

  @override
  List<Object> get props => [];
}

class LoadThemeHandBook extends HandBookEvent {
  LoadThemeHandBook() : super();

  @override
  List<Object> get props => [];
}

class LoadListArticle extends HandBookEvent {
  final String themeID;
  LoadListArticle({this.themeID}) : super();

  @override
  List<Object> get props => [];
}

class LoadArticle extends HandBookEvent {
  final String idTip;
  LoadArticle({this.idTip}) : super();

  @override
  List<Object> get props => [];
}
